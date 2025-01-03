class Parties
  def self.all
    url = "https://dadosabertos.camara.leg.br/api/v2/partidos"
    headers = {
      "Accept" => "application/json"
    }

    Rails.cache.fetch("parties_all", expires_in: 1.day) do
      response = Faraday.get(url, nil, headers)
      JSON.parse(response.body)
    end
  end
end
