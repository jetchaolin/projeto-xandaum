class CreateEventDeputies < ActiveRecord::Migration[8.0]
  def change
    create_table :event_deputies do |t|
      t.belongs_to :deputy
      t.belongs_to :event

      t.timestamps
    end
  end
end
