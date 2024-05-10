class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[destroy]

  def index
    @bookmarks = Bookmark.all
  end

  def create
    @bookmark = Bookmark.new(user_id: current_user.id, video_id: params[:video_id])
    if @bookmark.save
      flash[:notice] = "Successfully bookmarked video."
    else
      flash[:alert] = "Unable to bookmark video."
    end
    redirect_back(fallback_location: request.referer || root_path)
  end

  def destroy
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
