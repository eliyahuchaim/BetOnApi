Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users

      post '/login', to: 'sessions#create'
      get '/friends', to: 'users#friends'
      post '/givepoints', to: 'users#give_points'

    end
  end
end
