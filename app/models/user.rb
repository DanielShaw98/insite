require 'cgi'

class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :avatar, dependent: :destroy
  has_one :creator, dependent: :destroy
  has_many :pledges, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :socials, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  after_create :generate_placeholder_avatar

  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  validates :username, :email, :encrypted_password, presence: true
  validates :username, :email, uniqueness: true
  validates :email, format: { with: Devise.email_regexp }
  validates :username, length: { in: 4..30 }
  validates :encrypted_password, length: { in: Devise.password_length }
  validates :encrypted_password, format: { with: PASSWORD_FORMAT }
  validates :encrypted_password, confirmation: true

  def reviewed?(video)
    reviews.exists?(video_id: video.id)
  end

  COLORS = %w[#2596BE #E28743 #BE2596 #2C4251 #7DC95E #231942 #5A1807 #307351 #EF5B5B #1EFFBC].freeze

  def generate_placeholder_avatar
    initials = "#{first_name[0]}#{last_name[0]}"
    color = COLORS.sample
    background_color = color.delete('#') # Remove '#' from the color code
    background_color_encoded = CGI.escape("##{background_color}") # URL-encode the background color
    new_avatar = build_avatar(image_url: "https://ui-avatars.com/api/?name=#{initials}&background=#{background_color_encoded}&color=fff")
    new_avatar.save
  end

  def needs_placeholder_avatar?
    avatar.nil? || !avatar.image.attached?
  end

  def avatar_image_url
    if avatar&.image&.attached?
      url_for(avatar.image)
    else
      avatar&.image_url || '/app/assets/images/default_avatar.png'
    end
  end

  attr_accessor :current_password

  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

    if valid_password?(current_password)
      update(params, *options)
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end
  end
end
