class Camara::V2::DeputyUpsert
  # def self.call(json_deputy)
  #   Camara::V2::DeputyAdapter.call(json_deputy)
  # end

  def self.call(json_deputy, adapter = Camara::V2::DeputyAdapter, deputy_id = nil)
    adapter.call(json_deputy, deputy_id = nil)
  end
end
