class AddLimitToSpendForecasts < ActiveRecord::Migration[7.1]
  def change
    add_column :spend_forecasts, :channel_daily_spend_limit, :decimal, default: 0
  end
end
