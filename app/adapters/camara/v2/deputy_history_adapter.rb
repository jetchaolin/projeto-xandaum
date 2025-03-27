class Camara::V2::DeputyHistoryAdapter
  def self.call(array, deputy_id)
    filtered_data = array
    if filtered_data != nil
      filtered_data.map do |item|
        Deputy.find_by(external_id: deputy_id)
        .deputy_histories.find_or_initialize_by(datetime: item["dataHora"])
        .update({
          deputy_external_id: item["id"], # Deputy external ID (e.g., "204379")
          party_acronym: item["siglaPartido"], # Acronym of the party (e.g., "PROS")
          state_acronym: item["siglaUf"], # State acronym (e.g., "AP")
          legislature_id: item["idLegislatura"], # Legislature (e.g., 56)
          photo_url: item["urlFoto"], # Photo URL (e.g., "https://www.camara.leg.br/internet/deputado/bandep/204379.jpg")
          status: item["situacao"], # Status (e.g., "Exercício")
          electoral_condition: item["condicaoEleitoral"], # Electoral condition (e.g., "Titular")
          status_description: item["descricaoStatus"] # Status description (e.g., "Nome no início da legislatura / Partido no início da legislatura")
        }.compact_blank)
      end
    end
  end
end
