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
    @pledge = Pledge.new(pledge_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def pledge_params
    params.require(:pledge).permit(:content)
  end

  def set_pledge
    @pledge = Pledge.find(params[:id])
  end
end
