Rails.application.routes.draw do
  resources :enrollments do
    get :my_students, on: :collection
  end
  devise_for :users
  resources :courses do
    get :purchased, :pending_review, :created, on: :collection
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  root 'home#index'
  get 'activity', to: 'home#activity'
  get 'analytics', to: 'home#analytics'
  get 'users-per-day-charts', to: 'charts#users_per_day'
  get 'enrollments-per-day-charts', to: 'charts#enrollments_per_day'
  get 'course-popularity-charts', to: 'charts#course_popularity'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
