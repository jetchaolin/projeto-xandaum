class AddDeputyReferenceColumnToProfessionsTable < ActiveRecord::Migration[8.0]
  def change
    add_reference :professions, :deputy
  end
end
