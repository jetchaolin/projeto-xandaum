class DeputyExpense < ApplicationRecord
  belongs_to :deputy
  validates :document_code, uniqueness: true
end
