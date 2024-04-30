class AvatarsController < ApplicationController
  before_action :set_avatar, only: %i[show edit update destroy]

  def index
    @avatars = Avatar.all
  end

  def show
  end

  def new
    @avatar = Avatar.new
  end

  def create
    @avatar = Avatar.new(avatar_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def avatar_params
    params.require(:avatar).permit(:image_url)
  end

  def set_avatar
    @avatar = Avatar.find(params[:id])
  end
end
