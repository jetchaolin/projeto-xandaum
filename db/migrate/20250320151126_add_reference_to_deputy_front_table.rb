class AddReferenceToDeputyFrontTable < ActiveRecord::Migration[8.0]
  def change
    add_reference :deputy_fronts, :deputy
  end
end
