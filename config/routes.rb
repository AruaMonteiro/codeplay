Rails.application.routes.draw do
  root 'home#index'
  resources :courses, only: [:index, :show]
  resources :instructors, only: [:index, :show]

end
