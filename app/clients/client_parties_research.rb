class ClientPartiesResearch
  def self.search(parties_research)
    @parties_research = parties_research
    @get_parties_list_from_the_api = Rails.cache.read("parties_all") ? Rails.cache.fetch("parties_all") : Parties.all
    @filtered_parties_ids_and_acronym = @get_parties_list_from_the_api["dados"].map do |party|
      { id: (party["id"]).to_s, acronym: @parties_research[:acronym] }
    end
    @found_party = @filtered_parties_ids_and_acronym.find { |item| item[:id] == @parties_research[:id] }

    if @found_party.nil?
      return { "dados": "Evento não encontrado" }
    end

    @url1 = "https://dadosabertos.camara.leg.br/api/v2/partidos/#{@found_party[:id]}"
    @url2 = "https://dadosabertos.camara.leg.br/api/v2/partidos/#{@found_party[:id]}/membros"

    headers = {
      "Accept" => "application/json"
    }
    response1 = JSON.parse(Faraday.get(@url1, nil, headers).body)
    response2 = JSON.parse(Faraday.get(@url2, nil, headers).body)
    result = { "dados": [ { partido: response1["dados"] }, { membros: response2["dados"] } ] }
    json_result = { body: result.to_json }
    JSON.parse(json_result[:body])
  end
end
