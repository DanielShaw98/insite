class Avatar < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image_url, presence: true, unless: -> { image.attached? }
end
