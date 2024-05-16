class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update]

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
    if user_signed_in? && !current_user.reviewed?(@video)
      @review = current_user.reviews.build(review_params)
      @review.video = @video
      @review.user = current_user
      if @review.save
        redirect_to @video, notice: 'Review was successfully created.'
      else
        @reviews = @video.reviews.limit(3)
        render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'You have already left a review for this guide.' }, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @video = Video.find(params[:video_id])
    @review = @video.reviews.find(params[:id])
    if @review.destroy
      flash[:notice] = 'Review was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete the review.'
    end
    redirect_back(fallback_location: request.referer || root_path)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
