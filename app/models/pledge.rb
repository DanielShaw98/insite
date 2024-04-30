class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :creator

  validates :content, presence: true
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
