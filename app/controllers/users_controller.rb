class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show check_username_availability check_email_availability check_email_exists check_password_correct]
  before_action :set_user, only: %i[show purchases followings bookmarks destroy settings]

  def index
    @users = User.all
  end

  def show
  end

  def purchases
    @purchases = current_user.purchases.order(created_at: :desc)
  end

  def followings
    @followings = current_user.followings
    followed_creator_ids = current_user.followings.pluck(:creator_id)
    @following_videos = Video.joins(creator: :followings).where(followings: { creator_id: followed_creator_ids }).order(created_at: :desc)
  end

  def bookmarks
    @bookmarks = current_user.bookmarks
  end

  def check_username_availability
    username = params[:username]
    user = User.find_by(username: username)
    available = user.nil?
    render json: { available: available }
  end

  def check_email_availability
    email = params[:email]
    user = User.find_by(email: email)
    available = user.nil?
    render json: { available: available }
  end

  def check_email_exists
    email = params[:email]
    user = User.find_by(email: email)
    exists = !user.nil?
    render json: { exists: exists }
  end

  def check_password_correct
    email = params[:email]
    password = params[:password]

    user = User.find_by(email: email)

    if user && user.valid_password?(password)
      render json: { correct: true }
    else
      render json: { correct: false }
    end
  end

  def destroy
  end

  def settings
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
