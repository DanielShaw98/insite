class Video < ApplicationRecord
  include PgSearch::Model
  multisearchable against: :title

  belongs_to :creator
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :purchases, dependent: :destroy

  # Not including in presence audience, includes, views

  validates :title, :description, :requirements, :learning, :includes, :external_video_url, :thumbnail_url, :accessibility, :average_rating, presence: true
  validates :title, :external_video_url, :thumbnail_url, uniqueness: true
  validates :views, numericality: { greater_than: 0 }
  validates :average_rating, inclusion: { in: 1..5, message: 'must be between 1 and 5' }
  validates :accessibility, inclusion: { in: %w[purchase subscription both], message: '%<value> needs to be purchase, subscription or both' }

  def calculate_average_rating
    if reviews.any?
      total_rating = reviews.sum(:rating)
      average_rating = total_rating.to_f / reviews.count
      update(average_rating)
    else
      update(average_rating: nil)
    end
  end
end
