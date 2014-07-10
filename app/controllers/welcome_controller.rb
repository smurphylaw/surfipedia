class WelcomeController < ApplicationController
  before_action :plans_setup, only: [:home]

  def index
    @free_plan
    @premium_plan
  end

  def about
  end

  private

  def plans_setup
    @plans = Plan.all
    plans.each do |plan|
      if plan.id == 1
        @free_plan = plan
      else 
        @premium_plan = plan
      end
    end
  end
end
