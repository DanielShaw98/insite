class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @video, notice: 'Review submitted successfully.'
    else
      @reviews = @video.reviews.limit(3)
      render 'videos/show', alert: 'Failed to submit review.'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
