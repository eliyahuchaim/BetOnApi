Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users, :parties, :bets, :wagers

      post '/login', to: 'sessions#create'
      get '/friends', to: 'users#friends'
      post '/givepoints', to: 'users#give_points'
      get '/publicpartyshow/:id', to: 'parties#public_party_info'
      post '/invitetoparty', to: 'parties#invite_user'
      post '/mass_invite', to: 'parties#mass_invite'
      get '/my-wagers/:id', to: 'wagers#users_wagers'

    end
  end
end
