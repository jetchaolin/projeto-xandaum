class Vote < ApplicationRecord
  has_many :deputies, through: :deputy_votes
  has_many :deputy_votes
end
