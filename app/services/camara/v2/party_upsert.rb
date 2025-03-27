class Camara::V2::PartyUpsert
  def self.call(json_parties)
    Camara::V2::PartyAdapter.call(json_parties)
  end
end
