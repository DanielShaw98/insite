class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :purchase_cost, :purchase_status, :payment_details, presence: true
  validates :purchase_cost, numericality: { greater_than: 0 }
end
