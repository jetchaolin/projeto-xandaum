class Camara::V2::DeputyVoteAdapter
  def self.call(array, vote_id)
    filtered_data = array
    filtered_data.map do |item|
      deputy = Deputy.find_by(external_id: item["deputado_"]["id"])
      if !deputy.present?
        Camara::DeputySync.single({ id: item["deputado_"]["id"], name: item["deputado_"]["nome"], options: "deputado" })
        deputy = Deputy.find_by(external_id: item["deputado_"]["id"])
      end
      vote = Vote.find_by(external_id: vote_id)
      DeputyVote.find_or_initialize_by(deputy_id: deputy.id, vote_id: vote.id).save!
    end
  end
end
