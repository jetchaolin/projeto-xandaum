class Camara::PartySync
  MAIN = "partidos".freeze
  CACHE_KEY = "parties_all".freeze
  EXPIRING_TIME = 3.days
  PARAMS = { itens: 100 }
  def self.list
    json_parties = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME, PARAMS)
    Camara::V2::PartyUpsert.call(json_parties)
  end
end
