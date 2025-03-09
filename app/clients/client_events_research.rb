class ClientEventsResearch
  MAIN = "eventos".freeze
  CACHE_KEY = "events_all".freeze
  ERROR_MESSAGE = "Evento não encontrado".freeze
  EXPIRING_TIME = 5.days
  def self.search(events_research)
    event_client = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the events from the API
    Service::FilterFetchedData.call(events_research, event_client, ERROR_MESSAGE) # Compare the data from the API with the user input and filter
    Service::Url.call(MAIN, events_research)
  end
end
