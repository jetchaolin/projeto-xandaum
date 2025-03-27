class ChangeColumnDefaultExternalIdFromNullFalseToTrue < ActiveRecord::Migration[8.0]
  def change
    change_column_null :deputy_histories, :external_id, true
  end
end
