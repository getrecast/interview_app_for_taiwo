require 'csv'
class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.first || User.create(channels: %w[facebook radio	billboards])
  end
  helper_method :current_user
end
