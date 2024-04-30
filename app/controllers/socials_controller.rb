class SocialsController < ApplicationController
  before_action :set_social, only: %i[show edit update destroy]

  def index
    @socials = Social.all
  end

  def show
  end

  def new
    @social = Social.new
  end

  def create
    @social = Social.new(social_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def social_params
    params.require(:social).permit(:platform, :link, :icon_path)
  end

  def set_social
    @social = Social.find(params[:id])
  end
end
