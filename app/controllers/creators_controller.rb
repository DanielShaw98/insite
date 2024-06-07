class CreatorsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show videos pledges]
  before_action :set_creator, only: %i[show edit update destroy videos pledges]

  def index
    @creators = Creator.all
  end

  def show
    @follow = @creator.followed_by?(current_user)
    following = current_user.followings.find_by(creator_id: @creator.id)
    @following = following || current_user.followings.build(creator_id: @creator.id)
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
    @following = @creator.followed_by?(current_user)
  end

  private

  def creator_params
    params.require(:creator).permit(:bio, :specialisation)
  end

  def set_creator
    @creator = Creator.find(params[:id])
  end
end
