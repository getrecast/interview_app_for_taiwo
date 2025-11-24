class Budget
  attr_reader :processed_budget, :rows_lost, :start_date, :end_date, :channel_daily_spend_limit, :rows_lost, :user

  def initialize(budget_contents:, start_date:, end_date:, channel_daily_spend_limit:, user:)
    @budget_contents = CSV.parse(budget_contents, headers: true)
    @start_date = start_date
    @end_date = end_date
    @channel_daily_spend_limit = channel_daily_spend_limit.to_i
    @user = user
  end

  def spend_forecast_from_budget
    user.spend_forecasts.new(start_date:, end_date:, budget: processed_budget, channel_daily_spend_limit:, rows_lost:)
  end

  def process_budget
    filtered_budget = @budget_contents.select do |row|
      date = Date.parse(row['date'])
      total_spending = row.to_h.values[1..-1].map(&:to_i).sum
      date >= start_date && date <= end_date && total_spending < channel_daily_spend_limit
    end

    filtered_budget_array = filtered_budget.map(&:fields)
    filtered_budget_array.unshift(@budget_contents.headers)
    rows_lost = (@budget_contents.to_a - filtered_budget_array)
    rows_lost.unshift(@budget_contents.headers) if rows_lost.any?

    @processed_budget = filtered_budget_array
    @rows_lost = rows_lost
  end
end
