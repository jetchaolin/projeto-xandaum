class Camara::V2::DeputyAdapter
  def self.call(json)
    filtered_data = json
    search_party = Party.find_by(party_acronym: filtered_data["ultimoStatus"]["siglaPartido"])
    party_id = search_party.id
    Deputy.find_or_initialize_by(external_id: filtered_data["id"])
    .update({
      legal_name: filtered_data["nomeCivil"],
      cpf: filtered_data["cpf"],
      gender: filtered_data["sexo"],
      website_url: filtered_data["urlWebsite"],
      birthdate: filtered_data["dataNascimento"],
      death_date: filtered_data["dataFalecimento"],
      birth_state: filtered_data["ufNascimento"],
      birth_city: filtered_data["municipioNascimento"],
      education_level: filtered_data["escolaridade"],
      party_id: party_id,
      name: filtered_data["ultimoStatus"]["nome"],
      state_acronym: filtered_data["ultimoStatus"]["siglaUf"],
      legislature_external_id: filtered_data["ultimoStatus"]["idLegislatura"],
      photo_url: filtered_data["ultimoStatus"]["urlFoto"],
      email: filtered_data["ultimoStatus"]["email"],
      status_date: filtered_data["ultimoStatus"]["data"],
      electoral_name: filtered_data["ultimoStatus"]["nomeEleitoral"],
      status: filtered_data["ultimoStatus"]["situacao"],
      electoral_status: filtered_data["ultimoStatus"]["condicaoEleitoral"],
      status_description: filtered_data["ultimoStatus"]["descricaoStatus"],
      cabinet: filtered_data["ultimoStatus"]["gabinete"],
      social_medias: filtered_data["redeSocial"]
    }.compact_blank)
  end
end
