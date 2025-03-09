class ClientDeputiesResearch
  MAIN = "deputados"
  CACHE_KEY = "deputies_all".freeze
  ERROR_MESSAGE = "Deputado não encontrado".freeze
  EXPIRING_TIME = 5.days
  def self.search(deputies_research)
    user_research = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the deputies from the API
    Service::FilterFetchedData.call(deputies_research, user_research, ERROR_MESSAGE) # Compare the data from the API with the user input and filter
    Service::Url.call(MAIN, deputies_research)
  end
end
