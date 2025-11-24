require 'csv'

class BudgetsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def process_budget
    user = User.find(params[:user_id])
    budget.process_budget

    Turbo::StreamsChannel.broadcast_replace_to(
      user,
      target: "spend_forecast",
      partial: "spend_forecasts/form",
      locals: { user:, spend_forecast: budget.spend_forecast_from_budget}
    )
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def budget
    @budget ||= Budget.new(
      budget_contents: params[:budget_file_contents],
      start_date: Date.parse(params[:start_date]),
      end_date: Date.parse(params[:end_date]),
      channel_daily_spend_limit: params[:channel_daily_spend_limit].to_i,
      user:
    )
  end
end
