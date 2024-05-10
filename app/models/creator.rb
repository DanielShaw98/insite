class Creator < ApplicationRecord
  include PgSearch::Model
  multisearchable against: %i[username specialisation]

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

  private

  def bio_word_count
    if bio.present? && bio.split.length < 50
      errors.add(:bio, 'must have at least 50 words')
    elsif bio.present? && bio.split.length > 500
      errors.add(:bio, 'cannot exceed 500 words')
    end
  end
end
