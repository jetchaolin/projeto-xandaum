class Camara::V2::EventDeputyAdapter
  def self.call(array, event_id)
    filtered_data = array
    filtered_data.map do |item|
      deputy = Deputy.find_by(external_id: item["id"])
      if !deputy.present?
        Camara::DeputySync.single({ id: item["id"], name: item["nome"], options: "deputado" })
        deputy = Deputy.find_by(external_id: item["id"])
      end
      event = Event.find_by(external_id: event_id)
      EventDeputy.find_or_initialize_by(deputy_id: deputy.id, event_id: event.id).save!
    end
  end
end
