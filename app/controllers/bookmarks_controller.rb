class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def create
    @bookmark = Bookmark.new(user_id: current_user.id, video_id: params[:video_id])
    if @bookmark.save
      flash[:notice] = 'Successfully bookmarked video.'
    else
      flash[:alert] = 'Unable to bookmark video.'
    end
    redirect_back(fallback_location: request.referer || root_path)
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user.id, video_id: params[:video_id])
    if @bookmark.destroy
      flash[:notice] = 'Successfully unbookmarked video.'
    else
      flash[:alert] = 'Unable to unbookmark video.'
    end
    redirect_back(fallback_location: request.referer || root_path)
  end
end
