class FollowingsController < ApplicationController
  before_action :set_following, only: %i[destroy]

  def index
    @followings = Following.all
  end

  def create
    @following = Following.new(user_id: current_user.id, creator_id: params[:creator_id])
    if @following.save
      flash[:notice] = "Successfully followed creator."
    else
      flash[:alert] = "Unable to follow creator."
    end
    redirect_back(fallback_location: request.referer || root_path)
  end

  def destroy
  end

  private

  def set_following
    @following = Following.find(params[:id])
  end
end
