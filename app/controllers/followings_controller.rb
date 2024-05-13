class FollowingsController < ApplicationController
  def index
    @followings = Following.all
  end

  def create
    @following = Following.new(user_id: current_user.id, creator_id: params[:creator_id])
    if @following.save
      flash[:notice] = 'Successfully followed creator.'
    else
      flash[:alert] = 'Unable to follow creator.'
    end
    redirect_back(fallback_location: request.referer || root_path)
  end

  def destroy
    @following = Following.find_by(user_id: params[:user_id], creator_id: params[:creator_id])
    if @following.destroy
      flash[:notice] = 'Successfully unfollowed creator.'
    else
      flash[:alert] = 'Unable to unfollow creator.'
    end
    redirect_back(fallback_location: request.referer || root_path)
  end
end
