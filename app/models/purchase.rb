class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :purchase_status, :payment_details, presence: true
end
