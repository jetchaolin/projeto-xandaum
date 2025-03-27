class CreateDeputyVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :deputy_votes do |t|
      t.belongs_to :deputy
      t.belongs_to :vote

      t.timestamps
    end
  end
end
