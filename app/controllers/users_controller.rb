class UsersController < ApplicationController
  def download_budget_template_csv
    headers = ['date'] + current_user.channels

    csv_data = CSV.generate(headers: true) do |csv|
      csv << headers
      csv << [Date.today]
    end

    send_data csv_data, filename: "budget_template.csv", type: 'text/csv'
  end
end
