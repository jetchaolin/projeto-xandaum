class ClientDeputiesResearch
  def self.search(deputies_research)
    @user_research = deputies_research
    @get_deputies_list_from_the_api = Rails.cache.read("deputies_all") ? Rails.cache.fetch("deputies_all") : Deputies.all
    @filtered_deputies_ids_and_names = @get_deputies_list_from_the_api["dados"].map do |deputy|
      { id: deputy["id"], name: deputy["nome"] }
    end
    @found_deputy = @filtered_deputies_ids_and_names.find { |item| item[:name] == @user_research[:name] }

    if @found_deputy.nil?
      return { "dados": "Deputado não encontrado" }
    end

    if @user_research[:options] == "deputado"
      @url = "https://dadosabertos.camara.leg.br/api/v2/deputados/#{@found_deputy[:id]}"
    elsif @user_research[:options] == ("lideres" || "mesa")
      @url = "https://dadosabertos.camara.leg.br/api/v2/legislaturas/#{@found_deputy[:id]}/#{@user_research[:options]}"
    elsif @user_research[:initial_date].present?
      params = {
        dataInicio: @user_research[:initial_date],
        dataFim: @user_research[:final_date],
        ordenarPor: "dataHoraInicio",
        ordem: "DESC",
      }.compact_blank
      @url = "https://dadosabertos.camara.leg.br/api/v2/deputados/#{@found_deputy[:id]}/#{@user_research[:options]}"
    else
      @url = "https://dadosabertos.camara.leg.br/api/v2/deputados/#{@found_deputy[:id]}/#{@user_research[:options]}"
    end

    headers = {
      "Accept" => "application/json"
    }
    response = Faraday.get(@url, (params || nil), headers)
    result = JSON.parse(response.body)
    Rails.logger.debug "URL: #{result.dig('links', 0, 'href')}"
    result
  end
end
