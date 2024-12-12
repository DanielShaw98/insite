class Video < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title,
                  against: :title,
                  using: {
                    tsearch: { prefix: true }
                  }

  belongs_to :creator
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  # Not including in presence audience, includes, views

  validates :title, :description, :requirements, :learning, :includes, :external_video_url, :thumbnail_url, :average_rating, :price, presence: true
  validates :title, :external_video_url, :thumbnail_url, uniqueness: true
  validates :views, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }, unless: :free?
  validates :average_rating, inclusion: { in: 1..5, message: 'must be between 1 and 5' }
  validates :free, inclusion: { in: [true, false], message: '%<value> needs to be true or false' }

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
