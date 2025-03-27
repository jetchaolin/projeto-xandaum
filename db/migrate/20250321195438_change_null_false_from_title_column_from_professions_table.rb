class ChangeNullFalseFromTitleColumnFromProfessionsTable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :professions, :title, true
  end
end
