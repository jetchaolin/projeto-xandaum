class Votes
  def self.all
    url = "https://dadosabertos.camara.leg.br/api/v2/votacoes"
    headers = {
      "Accept" => "application/json"
    }

    Rails.cache.fetch("votes_all", expires_in: 1.day) do
      response = Faraday.get(url, nil, headers)
      JSON.parse(response.body)
    end
  end
  def self.by_date(initial_date, final_date)
    params = {
      dataInicio: initial_date,
      dataFim: final_date,
      ordenarPor: "dataHoraInicio",
      ordem: "DESC",
    }.compact_blank

    url = "https://dadosabertos.camara.leg.br/api/v2/votacoes"
    headers = {
      "Accept" => "application/json"
    }

    Rails.cache.fetch("filtered_votes", expires_in: 1.day) do
      response = Faraday.get(url, params, headers)
      JSON.parse(response.body)
    end
  end
end
