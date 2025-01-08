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
end
