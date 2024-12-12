class Creator < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_attributes,
                  against: :specialisation,
                  associated_against: {
                    user: :username
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  belongs_to :user
  has_many :pledges, dependent: :destroy
  has_many :socials, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :videos, dependent: :destroy

  validates :bio, :specialisation, presence: true
  validate :bio_word_count

  def username
    user&.username
  end

  def followed_by?(user)
    followings.exists?(user_id: user.id)
  end

  private

  def bio_word_count
    if bio.present? && bio.split.length < 50
      errors.add(:bio, 'must have at least 50 words')
    elsif bio.present? && bio.split.length > 500
      errors.add(:bio, 'cannot exceed 500 words')
    end
  end
end
