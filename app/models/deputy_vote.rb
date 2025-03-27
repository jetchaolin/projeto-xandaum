class DeputyVote < ApplicationRecord
  belongs_to :deputy
  belongs_to :vote
end
