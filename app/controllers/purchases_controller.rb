class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[show destroy]

  def index
    @purchases = current_user.purchases
  end

  def show
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
  end

  def destroy
  end

  private

  def purchase_params
    params.require(:purchase).permit(:payment_details)
  end

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end
end
