class Party < ApplicationRecord
  has_many :deputies
  validates :external_id, uniqueness: true
end
