class PagesController < ApplicationController
  include Pagy::Backend
  skip_before_action :authenticate_user!, only: %i[index search discover filter]

  def index
    @trending_videos = Video.where('created_at >= ?', 7.days.ago).order(views: :desc).limit(10)
    @popular_videos = Video.order(views: :desc).limit(10)
    @recent_videos = Video.order(created_at: :desc).limit(10)
  end

  def discover
    Pagy::DEFAULT[:items] = 16
    Pagy::DEFAULT[:size]  = [1, 4, 4, 1]
    @pagy, @filter_videos = pagy(Video.all)
  end

  def filter
    @category = params[:category]
    @sort_by = params[:sort_by]
    @sort_direction = params[:sort_direction]

    if @category.present? && @category.downcase == 'all'
      @filter_videos = Video.all
    else
      category_name = @category.downcase if @category.present?
      @filter_videos = Video.includes(:category)

      if category_name.present?
        @filter_videos = @filter_videos.joins(:category).where('LOWER(categories.name) = ?', category_name)
      end
    end

    sort_options = {}

    if params[:sort_by].present?
      case params[:sort_by]
      when 'views'
        sort_options[:views] = params[:sort_direction].to_sym if params[:sort_direction].present?
      when 'rating'
        sort_options[:average_rating] = params[:sort_direction].to_sym if params[:sort_direction].present?
      when 'date'
        sort_options[:created_at] = params[:sort_direction].to_sym if params[:sort_direction].present?
      end
    end

    @pagy, @filter_videos = pagy(@filter_videos.order(sort_options))

    render 'discover'
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
    video_results = Video.search_by_title(query).limit(5)
    creator_results = Creator.search_by_attributes(query).limit(5)

    suggestions = []
    suggestions += video_results.map { |video| { text: video.title, url: video_path(video), type: 'video', image: video.thumbnail_url } }
    suggestions += creator_results.map { |creator| { text: creator.user.username, url: user_creator_path(creator.user, creator), type: 'avatar', image: creator.user.avatar_image_url } }

    suggestions
  end
end
