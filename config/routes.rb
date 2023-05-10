Rails.application.routes.draw do
  resources :ignored_words
  resources :guesses
  root "dashboard#index"
end
