class DropDeputyHistories < ActiveRecord::Migration[8.0]
  def change
    drop_table :deputy_histories
  end
end
