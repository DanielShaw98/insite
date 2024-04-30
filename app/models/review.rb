class Review < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :content, :rating, presence: true
  validates :rating, inclusion: { in: 1..5, message: 'must be between 1 and 5' }
  validate :content_word_count

  private

  def content_word_count
    if content.present? && content.split.length < 20
      errors.add(:content, 'must have at least 20 words')
    elsif content.present? && content.split.length > 300
      errors.add(:content, 'cannot exceed 300 words')
    end
  end
end
