class CreatorsController < ApplicationController
  before_action :set_creator, only: %i[show edit update destroy videos pledges]

  def index
    @creators = Creator.all
  end

  def show
  end

  def new
    @creator = Creator.new
  end

  def create
    @creator = Creator.new(creator_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def videos
    @videos = @creator.videos
  end

  def pledges
    @pledges = @creator.pledges
  end

  private

  def creator_params
    params.require(:creator).permit(:bio, :specialisation)
  end

  def set_creator
    @creator = Creator.find(params[:id])
  end
end
