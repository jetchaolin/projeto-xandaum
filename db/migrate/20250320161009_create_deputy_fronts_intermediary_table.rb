class CreateDeputyFrontsIntermediaryTable < ActiveRecord::Migration[8.0]
  def change
    create_table :deputy_fronts do |t|
      t.belongs_to :deputy
      t.belongs_to :front

      t.timestamps
    end
  end
end
