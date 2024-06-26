class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def create
    @category = Category.new(category_params)
  end

  def update
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
