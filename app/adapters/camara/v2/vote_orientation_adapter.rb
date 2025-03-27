class Camara::V2::VoteOrientationAdapter
  def self.call(json)
    filtered_data = json
    filtered_data.map do |item|
      VoteOrientation.find_or_create_by(party_bloc_acronym: item["siglaPartidoBloco"])
      .update({
        vote_orientation: item["orientacaoVoto"],
        leadership_type_code: item["codTipoLideranca"],
        party_bloc_code: item["codPartidoBloco"],
        party_bloc_uri: item["uriPartidoBloco"]
      }.compact_blank)
    end
  end
end
