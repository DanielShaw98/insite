class Video < ApplicationRecord
  belongs_to :creator
  belongs_to :category
end
