class Front < ApplicationRecord
  has_many :deputies, through: :deputy_fronts
  has_many :deputy_fronts
end
