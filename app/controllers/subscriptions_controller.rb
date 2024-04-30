class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show edit update destroy]

  def index
    @subscriptions = current_user.subscriptions
    subscribed_creator_ids = current_user.subscriptions.pluck(:creator_id)
    @subscription_videos = Video.joins(creator: :subscriptions).where(subscriptions: { creator_id: subscribed_creator_ids }).order(created_at: :desc)
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
