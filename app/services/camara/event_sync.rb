class Camara::EventSync
  MAIN = "eventos".freeze
  CACHE_KEY = "events_all".freeze
  EXPIRING_TIME = 3.days
  PARAMS = { itens: 5000 }
  def self.list
    json_events = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the events from the API
    events_list = json_events["dados"] # Remove the "dados" tag
    events_list.map do |event|
      events_research = { id: event["id"], options: "eventos" }
      sleep(0.3)
      event_found = ClientEventsResearch.search(events_research)["dados"]
      Camara::V2::EventAdapter.call(event_found)
    end
  end

  def self.deputies
    json_events = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME) # Fetch and list the events from the API
    events_list = json_events["dados"] # Remove the "dados" tag
    events_list.map do |event|
      deputies_research = { id: event["id"], options: "deputados" }
      sleep(0.5)
      deputies_events = ClientEventsResearch.search(deputies_research)["dados"]
      Camara::V2::EventDeputyAdapter.call(deputies_events, event["id"])
    end
  end
end
