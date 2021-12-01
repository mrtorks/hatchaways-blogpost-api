Rails.application.routes.draw do
  # get 'ping/index'

  namespace :api do
    resources :posts
    resources :ping
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
