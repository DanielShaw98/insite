class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show check_username_availability check_email_availability check_email_exists check_password_correct]
  before_action :set_user, only: %i[show purchases followings bookmarks user_reviews user_pledges settings update_username update_password update_avatar destroy_avatar]

  def index
    @users = User.all
  end

  def show
    @reviews = @user.reviews.limit(3).order(created_at: :desc)
    @has_more = @user.reviews.count > 3

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end

    @pledges = @user.pledges.limit(3).order(created_at: :desc)
    @has_more_pledges = @user.pledges.count > 3
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

  def user_reviews
    @reviews = @user.reviews.offset(params[:offset].to_i).limit(3).order(created_at: :desc)
    @has_more = @user.reviews.count > params[:offset].to_i + @reviews.count

    respond_to do |format|
      format.json {
        render json: {
          reviews: @reviews.as_json(include: {
            user: { only: %i[id username], methods: [:avatar_image_url] },
            video: {
              only: %i[id title thumbnail_url average_rating],
              include: {
                creator: { only: [], include: { user: { only: %i[id username] } } }
              }
            }
          }),
          has_more: @has_more
        }
      }
    end
  end

  def user_pledges
    @pledges = @user.pledges.offset(params[:offset].to_i).limit(3).order(created_at: :desc)
    @has_more_pledges = @user.pledges.count > params[:offset].to_i + @pledges.count

    respond_to do |format|
      format.json {
        render json: {
          pledges: @pledges.as_json(include: {
            user: { only: %i[id username], methods: [:avatar_image_url] },
            creator: { only: %i[id specialisation], include: { user: { only: %i[id username], methods: [:avatar_image_url] } } }
          }),
          has_more: @has_more_pledges
        }
      }
    end
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

  def settings
  end

  def update_username
    if @user.update(user_params)
      respond_to do |format|
        format.json { render json: { status: 'success', message: 'Username successfully changed.' } }
        format.html { redirect_to settings_user_path(@user) }
      end
    else
      respond_to do |format|
        format.json { render json: { status: 'error', message: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity }
        format.html { render :settings }
      end
    end
  end

  def update_password
    if @user.update_with_password(password_params)
      sign_in(@user, bypass: true)
      respond_to do |format|
        format.json { render json: { status: 'success', message: 'Password successfully changed.' } }
        format.html { redirect_to settings_user_path(@user), notice: 'Password successfully changed.' }
      end
    else
      respond_to do |format|
        format.json { render json: { status: 'error', message: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity }
        format.html { render :settings, alert: @user.errors.full_messages.to_sentence }
      end
    end
  end

  def update_avatar
    @avatar = @user.avatar || @user.build_avatar
    if @avatar.update(avatar_params)
      render json: { status: 'success', message: 'Avatar successfully changed.' }
    else
      render json: { status: 'error', message: @avatar.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy_avatar
    @avatar = @user.avatar
    if @avatar&.image&.attached?
      @avatar.image.purge
      @user.generate_placeholder_avatar if @user.needs_placeholder_avatar?
      render json: { status: 'success', message: 'Avatar successfully removed.' }
    else
      render json: { status: 'error', message: 'No avatar to remove.' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def avatar_params
    params.require(:avatar).permit(:image)
  end
end
