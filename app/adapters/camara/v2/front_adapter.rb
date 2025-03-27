class Camara::V2::FrontAdapter
  def self.call(array, deputy_id)
    filtered_data = array
    if filtered_data != nil
      filtered_data.map do |item|
        # Find or initialize the front record by a unique identifier (e.g., external_id or a combination of fields)
        # Deputy.find_by(external_id: deputy_id)
        # .fronts.find_or_initialize_by(external_id: item["id"])
        deputy = Deputy.find_by(external_id: deputy_id)
        front = Front.find_or_initialize_by(external_id: item["id"])
        front.update({
          title: item["titulo"] # Title
        }.compact_blank) # Remove blank values to avoid overwriting with nil
        DeputyFront.find_or_initialize_by(deputy_id: deputy.id, front_id: front.id).save!
      end
    end
  end
end
