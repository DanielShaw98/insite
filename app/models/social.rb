class Social < ApplicationRecord
  belongs_to :user
  belongs_to :creator

  validates :platform, :link, :icon_path, presence: true
end
