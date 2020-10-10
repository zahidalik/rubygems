Rails.application.routes.draw do
  resources :lessons
  devise_for :users
  resources :courses
  resources :users, only: [:index, :edit, :show, :update]
  root 'home#index'
  get 'activity', to: 'home#activity'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
