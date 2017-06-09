Rails.application.routes.draw do
  resources :games
  devise_for :users
  root to: 'games#rank'
  get '/user',     to: 'home#user'
  get 'rank',     to: 'games#rank'

end
