class ClientVotesResearch
  MAIN = "votacoes".freeze
  CACHE_KEY = "votes_all".freeze
  ERROR_MESSAGE = "Votação não encontrado".freeze
  EXPIRING_TIME = 5.days
  def self.search(votes_research)
    votes_client = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the votes from the API
    Service::FilterFetchedData.call(votes_research, votes_client, ERROR_MESSAGE) # Compare the data from the API with the user input and filter
    Service::Url.call(MAIN, votes_research)
  end
end
