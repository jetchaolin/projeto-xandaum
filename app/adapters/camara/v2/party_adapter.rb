class Camara::V2::PartyAdapter
  def self.call(json)
    filtered_data = json["dados"]
    filtered_data.map do |item|
      Party.find_or_create_by(external_id: item["id"])
      .update(party_name: item["nome"], party_acronym: item["sigla"])
    end
  end
end
