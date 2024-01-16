# config/routes.rb

Rails.application.routes.draw do
  root 'games#index'  # Adds root path to go directly to the games list
  resources :games

  
  # ... other routes ...
end
