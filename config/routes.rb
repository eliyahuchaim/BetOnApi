Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users, :parties

      post '/login', to: 'sessions#create'
      get '/friends', to: 'users#friends'
      post '/givepoints', to: 'users#give_points'
      get '/publicpartyshow/:id', to: 'parties#public_party_info' 

    end
  end
end
