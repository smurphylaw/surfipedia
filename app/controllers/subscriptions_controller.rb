class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :plans_setup

  def new
    @plans = Plan.all 
    @subscription = current_user.build_subscription
  end
  
  def create
      @subscription = current_user.build_subscription(subscription_params)
      @plans = Plan.all
        if @subscription.save_with_payment
          redirect_to root_path
        else
        render :new
      end
    else
      
    end
  end

  def show
    @subscription = User.find(params[:id])
  end

  private

  def subscription_params
    params.require(:subscription).permit(:user_id, :email, :plan_id, :stripe_card_token)
  end

  def plans_setup
    plans = Plan.all
    plans.each do |plan|
      if plan.id == 1
        @free_plan = plan
      else 
        @premium_plan = plan
      end
    end
  end
end