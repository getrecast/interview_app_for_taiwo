class CreateSpendForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.json :channels
    end

    create_table :spend_forecasts do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.json :budget
      t.string :status, default: :draft
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
