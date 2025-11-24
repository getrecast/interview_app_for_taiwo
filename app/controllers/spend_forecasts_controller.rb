class SpendForecastsController < ApplicationController
  before_action :set_spend_forecast, only: [:download_budget_csv, :show]

  def index
    @spend_forecasts = SpendForecast.all
  end

  def new
    @spend_forecast = current_user.spend_forecasts.find_by(status: :draft) || current_user.spend_forecasts.create
  end

  def edit
    @spend_forecast = current_user.spend_forecasts.draft.find(params[:id])
  end

  def update
    @spend_forecast = current_user.spend_forecasts.draft.find(params[:id])
    @spend_forecast.update(spend_forecast_params)

    if @spend_forecast.update(status: :in_progress)
      redirect_to spend_forecast_path(@spend_forecast)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if spend_forecast.update(spend_forecast_params)
      redirect_to spend_forecast_path(spend_forecast)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create
    if spend_forecast.update(spend_forecast_params)
      redirect_to spend_forecast_path(spend_forecast)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show;end

  def download_budget_csv
    csv_data = CSV.generate(headers: true) do |csv|
      @spend_forecast.budget.each do |row|
        csv << row
      end
    end

    send_data csv_data, filename: "#{@spend_forecast.name}.csv", type: 'text/csv'
  end

  private

  def set_spend_forecast
    @spend_forecast = current_user.spend_forecasts.find(params[:id])
  end

  def spend_forecast_params
    params.require(:spend_forecast).permit(:name, :start_date, :end_date, :channel_daily_spend_limit, :budget)
  end
end
