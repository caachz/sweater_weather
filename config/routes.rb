Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :forecast, only: [:show]
      resource :backgrounds, only: [:show]
      resource :users, only: [:create]
      resource :sessions, only: [:create]
      resource :road_trip, only: [:create]
    end
  end

  root to: "home#index"
end
