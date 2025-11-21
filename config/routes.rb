Rails.application.routes.draw do
  root "spend_forecasts#index"
  resources :spend_forecasts, except: [:destroy, :create] do
    get :download_budget_csv, on: :member
  end

  resources :users, only: [] do
    get :download_budget_template_csv, on: :member
  end
end
