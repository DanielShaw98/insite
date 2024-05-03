class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def subscription_params
    params.require(:subscription).permit(:payment_details)
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
