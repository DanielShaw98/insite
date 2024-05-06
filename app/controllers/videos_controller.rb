class VideosController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show video_reviews]
  before_action :set_video, only: %i[show video_reviews edit update destroy]

  def index
    @videos = Video.all
  end

  def show
    @reviews = @video.reviews.limit(3)
    @has_more = @video.reviews.count > 3

    respond_to do |format|
      format.html
      format.json { render json: @video }
    end
  end

  def video_reviews
    @reviews = @video.reviews.offset(params[:offset].to_i).limit(3)
    @has_more = @video.reviews.count > params[:offset].to_i + @reviews.count

    puts @has_more

    respond_to do |format|
      format.json {
        render json: {
          reviews: @reviews.as_json(include: { user: { only: %i[id username], methods: [:avatar_image_url] } }),
          has_more: @has_more
        }
      }
    end
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :requirements, :learning, :audience, :includes, :external_video_url, :thumbnail_url, :accessibility)
  end

  def set_video
    @video = Video.find(params[:id])
  end
end
