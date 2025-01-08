class ClientVotesResearch
  def self.search(votes_research)
    @votes_research = votes_research
    @get_votes_list_from_the_api = Rails.cache.read("votes_all") ? Rails.cache.fetch("votes_all") : Votes.all
    @filtered_votes_ids_and_options = @get_votes_list_from_the_api["dados"].map do |vote|
      { id: (vote["id"]).to_s, options: @votes_research[:options] }
    end
    @found_vote = @filtered_votes_ids_and_options.find { |item| item[:id] == @votes_research[:id] }

    if @found_vote.nil?
      return { "dados": "Votação não encontrada" }
    end

    if @votes_research[:options] == "votacoes"
      @url = "https://dadosabertos.camara.leg.br/api/v2/votacoes/#{@found_vote[:id]}"
    else
      @url = "https://dadosabertos.camara.leg.br/api/v2/votacoes/#{@found_vote[:id]}/#{@votes_research[:options]}"
    end

    headers = {
      "Accept" => "application/json"
    }
    response = Faraday.get(@url, nil, headers)
    JSON.parse(response.body)
  end
end
