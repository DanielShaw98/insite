class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :user, :video, presence: true
end
