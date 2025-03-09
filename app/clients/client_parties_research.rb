class ClientPartiesResearch
  MAIN = "partidos".freeze
  CACHE_KEY = "parties_all".freeze
  DEPENDENCY = "membros".freeze
  ERROR_MESSAGE = "Partido não encontrado".freeze
  EXPIRING_TIME = 3.days
  def self.search(id_and_acronym_of_the_party)
    party_client = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the parties from the API
    Service::FilterFetchedData.call(id_and_acronym_of_the_party, party_client, ERROR_MESSAGE) # Compare the data from the API with the user input and filter
    Service::Url.call(MAIN, id_and_acronym_of_the_party, DEPENDENCY)
  end
end
