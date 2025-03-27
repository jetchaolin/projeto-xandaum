class Event < ApplicationRecord
  has_many :deputies, through: :event_deputies
  has_many :event_deputies
end
