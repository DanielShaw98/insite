require 'cgi'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :generate_placeholder_avatar

  has_one :avatar, dependent: :destroy
  has_one :creator, dependent: :destroy
  has_many :pledges, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :socials, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

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

  def avatar_image_url
    avatar&.image_url
  end

  COLORS = %w[#2596BE #E28743 #BE2596 #2C4251 #7DC95E #231942 #5A1807 #307351 #EF5B5B #1EFFBC].freeze

  def generate_placeholder_avatar
    initials = "#{first_name[0]}#{last_name[0]}"
    color = COLORS.sample
    background_color = color.delete('#') # Remove '#' from the color code
    background_color_encoded = CGI.escape("##{background_color}") # URL-encode the background color
    avatar = build_avatar(image_url: "https://ui-avatars.com/api/?name=#{initials}&background=#{background_color_encoded}&color=fff")
    avatar.save
  end
end
