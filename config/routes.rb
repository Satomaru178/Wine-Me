Rails.application.routes.draw do

  root to: "brands#index"

  resources :brands, only: :index

end
