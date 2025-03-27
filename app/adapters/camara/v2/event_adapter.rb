class Camara::V2::EventAdapter
  def self.call(json)
    filtered_data = json
    Event.find_or_create_by(external_id: filtered_data["id"])
    .update({
      start_time: filtered_data["dataHoraInicio"],
      end_time: filtered_data["dataHoraFim"],
      status: filtered_data["situacao"],
      event_type: filtered_data["descricaoTipo"],
      description: filtered_data["descricao"],
      external_location: filtered_data["localExterno"],
      chamber_location: filtered_data["localCamara"],
      recording_url: filtered_data["urlRegistro"],
      organs: filtered_data["orgaos"]
    }.compact_blank)
  end
end
