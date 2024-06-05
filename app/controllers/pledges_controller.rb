class PledgesController < ApplicationController
  before_action :set_pledge, only: %i[show edit update destroy]

  def index
    @pledges = Pledge.all
  end

  def show
  end

  def new
    @pledge = Pledge.new
  end

  def create
    @creator = Creator.find(params[:pledge][:creator_id])
    @pledge = Pledge.new(pledge_params)
    @pledge.user = current_user
    if @pledge.save
      redirect_to user_creator_path(@creator.user, @creator), notice: 'Pledge was successfully created.'
    else
      logger.debug @pledge.errors.full_messages
      render 'creators/show', status: :unprocessable_entity, locals: { errors: @pledge.errors.full_messages }
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if @pledge.destroy
      flash[:notice] = 'Review was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete the review.'
    end
    redirect_back(fallback_location: request.referer || root_path)
  end

  private

  def pledge_params
    params.require(:pledge).permit(:content, :creator_id)
  end

  def set_pledge
    @pledge = Pledge.find(params[:id])
  end
end
