class SpendForecast < ApplicationRecord
  STATUSES = %w[draft in_progress completed].freeze

  validates :name, presence: true, unless: :draft?
  validates :start_date, presence: true, unless: :draft?
  validates :end_date, presence: true, unless: :draft?
  validates :budget, presence: true, unless: :draft?
  validates :status, presence: true, inclusion: { in: STATUSES }
  validate :end_date_after_start_date

  attr_accessor :budget_file, :rows_lost

  enum status: STATUSES.index_by(&:to_sym)

  belongs_to :user

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, "must be after or equal to start date")
    end
  end
end
