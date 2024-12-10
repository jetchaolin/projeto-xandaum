class Deputies
  def self.all
    url = "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome"
    headers = {
      "Accept" => "application/json"
    }

    Rails.cache.fetch("deputies_all", expires_in: 5.day) do
      response = Faraday.get(url, nil, headers)
      JSON.parse(response.body)
    end
  end
end
