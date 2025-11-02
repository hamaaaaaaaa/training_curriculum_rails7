Rails.application.routes.draw do
  root 'calendars#index'
  resources :calendars, only: [:index, :create]
end
