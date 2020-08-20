Rails.application.routes.draw do
  resources :brands, only: :index
end
