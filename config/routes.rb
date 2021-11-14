Rails.application.routes.draw do
  root 'home#index'
  get '/route', to: 'home#route'
end
