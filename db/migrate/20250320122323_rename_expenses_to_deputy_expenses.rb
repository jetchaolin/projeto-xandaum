class RenameExpensesToDeputyExpenses < ActiveRecord::Migration[8.0]
  def change
    rename_table :expenses, :deputy_expenses
  end
end
