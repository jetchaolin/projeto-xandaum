module Service
  class FetchList
    def self.call(subject, cache, expiring_time = 1.day)
      url = "https://dadosabertos.camara.leg.br/api/v2/#{subject}"
      headers = {
        "Accept" => "application/json"
      }

      Rails.cache.fetch(cache, expires_in: expiring_time) do
        response = Faraday.get(url, nil, headers)
        JSON.parse(response.body)
      end
    end

    def self.by_date(subject, cache, expiring_time = 1.day, initial_date, final_date)
      params = {
        dataInicio: initial_date,
        dataFim: final_date,
        ordenarPor: "dataHoraRegistro",
        ordem: "DESC",
      }.compact_blank

      url = "https://dadosabertos.camara.leg.br/api/v2/#{subject}"
      headers = {
        "Accept" => "application/json"
      }

      Rails.cache.fetch(cache, expires_in: expiring_time) do
        response = Faraday.get(url, params, headers)
        JSON.parse(response.body)
      end
    end
  end

  class FilterFetchedData
    def self.call(research_data, research_service, error)
      research_data_id = research_data[:id]
      research_data_option = research_data[:options]
      filtered_service = research_service["dados"].map do |r|
        { id: (r["id"]).to_s, options: research_data_option }
      end
      result = filtered_service.find { |item| item[:id] == research_data_id } || { "dados": "#{error}" }
    end
  end

  class Url
    def self.call(main, subject, dependency = nil)
      if main == "deputados"
        if subject[:options] == "deputado"
          url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}"
        elsif subject[:options] == "lideres"
          url = "https://dadosabertos.camara.leg.br/api/v2/legislaturas/#{subject[:id]}/#{subject[:options]}"
        elsif subject[:initial_date].present?
          if subject[:options] == "mesa"
            params = {
              dataInicio: subject[:initial_date],
              dataFim: subject[:final_date],
            }.compact_blank
            url = "https://dadosabertos.camara.leg.br/api/v2/legislaturas/#{subject[:id]}/#{subject[:options]}"
          elsif subject[:options] == "orgaos"
            params = {
              dataInicio: subject[:initial_date],
              dataFim: subject[:final_date],
              ordenarPor: "dataInicio",
              ordem: "DESC",
            }.compact_blank
            url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}/#{subject[:options]}"
          else
            params = {
              dataInicio: subject[:initial_date],
              dataFim: subject[:final_date],
              ordenarPor: "dataHoraInicio",
              ordem: "DESC",
            }.compact_blank
            url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}/#{subject[:options]}"
          end
        else
          url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}/#{subject[:options]}"
        end

        headers = {
          "Accept" => "application/json"
        }
        response = Faraday.get(url, (params || nil), headers)
        result = JSON.parse(response.body)
        Rails.logger.debug "URL: #{result.dig('links', 0, 'href')}, #{url}"
        result
      elsif main == "eventos"
        if subject[:options] == "eventos"
          url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}"
        elsif subject[:options] == ("situacoesEvento" || "tiposEvento")
          url = "https://dadosabertos.camara.leg.br/api/v2/referencias/#{subject[:options]}"
        elsif subject[:options] == ("codSituacaoEvento" || "codTipoEvento")
          url = "https://dadosabertos.camara.leg.br/api/v2/referencias/eventos/#{subject[:options]}"
        elsif subject[:initial_date].present?
          params = {
            dataInicio: @user_research[:initial_date],
            dataFim: @user_research[:final_date],
            ordenarPor: "dataHoraInicio",
            ordem: "DESC",
          }.compact_blank
          url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}/#{subject[:options]}"
        else
          url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}/#{subject[:options]}"
        end

        headers = {
          "Accept" => "application/json"
        }
        response = Faraday.get(url, (params || nil), headers)
        result = JSON.parse(response.body)
        Rails.logger.debug "URL: #{result.dig('links', 0, 'href')}, #{url}"
        result
      elsif main == "partidos"
        first_url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}"
        second_url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}/#{dependency}"

        headers = {
          "Accept" => "application/json"
        }
        response1 = JSON.parse(Faraday.get(first_url, nil, headers).body)
        response2 = JSON.parse(Faraday.get(second_url, nil, headers).body)

        Rails.logger.debug "URLs: #{response1.dig('links', 0, 'href')} - #{response2.dig('links', 0, 'href')}"
        result = { "dados": [ { partido: response1["dados"] }, { membros: response2["dados"] } ] }
        JSON.parse(result.to_json)
      else
        if subject[:options] == "votacoes"
          url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}"
        else
          url = "https://dadosabertos.camara.leg.br/api/v2/#{main}/#{subject[:id]}/#{subject[:options]}"
        end

        headers = {
          "Accept" => "application/json"
        }
        response = Faraday.get(url, nil, headers)
        result = JSON.parse(response.body)
        Rails.logger.debug "URL: #{result.dig('links', 0, 'href')}"
        result
      end
    end
  end
end
