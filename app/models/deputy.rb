class Deputy < ApplicationRecord
  belongs_to :party, optional: true
  has_many :deputy_expenses, dependent: :destroy
  has_many :deputy_external_mandates, dependent: :destroy
  has_many :deputy_fronts, dependent: :destroy
  has_many :deputy_histories, dependent: :destroy
  has_many :deputy_ocupations, dependent: :destroy
  has_many :deputy_speeches, dependent: :destroy
  has_many :deputy_votes, dependent: :destroy
  has_many :event_deputies, dependent: :destroy
  has_many :professions, dependent: :destroy
  has_many :events, through: :event_deputies
  has_many :fronts, through: :deputy_fronts
  has_many :votes, through: :deputy_votes
  validates :external_id, uniqueness: true
end
