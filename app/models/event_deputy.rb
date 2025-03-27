class EventDeputy < ApplicationRecord
  belongs_to :deputy
  belongs_to :event
end
