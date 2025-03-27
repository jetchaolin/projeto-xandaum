class ChangeNullFalseColumnFromProfessionsTable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :professions, :profession_type_code, true
  end
end
