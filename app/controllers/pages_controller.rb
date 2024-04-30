class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index search]

  def index
    @trending_videos = Video.where('created_at >= ?', 7.days.ago).order(views: :desc).limit(6)
    @popular_videos = Video.order(views: :desc).limit(6)
    @recent_videos = Video.order(created_at: :desc).limit(6)
  end

  def discover
  end

  def show
    @video = Video.find_by(id: params[:id])

    if @video.nil?
      flash[:alert] = 'Video not found'
      redirect_to root_path
      return
    end
    render 'videos/show'
  end

  def search
    query = params[:query]

    suggestions = perform_search(query)

    render json: { suggestions: suggestions }
  end

  private

  def perform_search(query)
    video_results = Video.where("title ILIKE :query", query: "%#{query}%").limit(5)
    creator_results = Creator.joins(:user).where("users.username ILIKE :query OR creators.specialisation ILIKE :query", query: "%#{query}%").limit(5)

    suggestions = []
    suggestions += video_results.map { |video| { text: video.title, url: video_path(video), type: 'video', image: video.thumbnail_url } }
    suggestions += creator_results.map { |creator| { text: creator.username, url: user_path(creator.user), type: 'avatar', image: creator.user.avatar.image_url } }

    suggestions
  end
end
