class Camara::VoteSync
  MAIN = "votacoes".freeze
  CACHE_KEY = "votes_all".freeze
  EXPIRING_TIME = 3.days
  PARAMS = { itens: 5000 }
  def self.list
    json_votes = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the votes from the API
    votes_list = json_votes["dados"] # Remove the "dados" tag
    votes_list.map do |vote|
      votes_research = { id: vote["id"], options: "votacoes" }
      sleep(0.3)
      vote_found = ClientVotesResearch.search(votes_research)["dados"]
      Camara::V2::VoteAdapter.call(vote_found)
    end
  end


  def self.deputies
    json_votes = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the votes from the API
    votes_list = json_votes["dados"] # Remove the "dados" tag
    votes_list.map do |vote| # Iterate over the array
      votes_research = { id: vote["id"], options: "votos" }
      sleep(0.3)
      vote_found = ClientVotesResearch.search(votes_research)["dados"]
      Camara::V2::DeputyVoteAdapter.call(vote_found, vote["id"])
    end
  end

  def self.orientations
    json_votes = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the votes from the API
    votes_list = json_votes["dados"] # Remove the "dados" tag
    votes_list.map do |vote| # Iterate over the array
      votes_research = { id: vote["id"], options: "orientacoes" }
      sleep(0.3)
      vote_found = ClientVotesResearch.search(votes_research)["dados"]
      Camara::V2::VoteOrientationAdapter.call(vote_found)
    end
  end
end
