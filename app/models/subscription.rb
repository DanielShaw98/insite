class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :creator

  validates :subscription_cost, :subscription_status, :payment_details, :start_date, :end_date, presence: true
  validates :subscription_cost, numericality: { greater_than: 0 }
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    errors.add(:end_date, 'must be after start date') if end_date <= start_date
  end
end
