Rails.application.routes.draw do
  resources :games
  devise_for :users
  root to: "home#index"
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'
  get '/user',     to: 'home#user'
  get 'rank',     to: 'games#rank'

end
