class Following < ApplicationRecord
  belongs_to :user
  belongs_to :creator

  validates :user, :creator, presence: true
end
