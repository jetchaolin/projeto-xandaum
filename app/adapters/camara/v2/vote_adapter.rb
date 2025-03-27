class Camara::V2::VoteAdapter
  def self.call(json)
    filtered_data = json
    Vote.find_or_create_by(external_id: filtered_data["id"])
    .update({
      date: filtered_data["data"],
      registration_datetime: filtered_data["dataHoraRegistro"],
      organ_acronym: filtered_data["siglaOrgao"],
      organ_id: filtered_data["idOrgao"],
      event_id: filtered_data["idEvento"],
      description: filtered_data["descricao"],
      approval_type: filtered_data["aprovacao"],
      last_opening_description: filtered_data["descUltimaAberturaVotacao"],
      last_opening_datetime: filtered_data["dataHoraUltimaAberturaVotacao"],
      last_proposition: filtered_data["ultimaApresentacaoProposicao"],
      registered_effects: filtered_data["efeitosRegistrados"] || [],
      possible_objects: filtered_data["objetosPossiveis"] || [],
      affected_propositions: filtered_data["proposicoesAfetadas"]
    }.compact_blank)
  end
end
