Rails.application.routes.draw do
  root to: 'categories#show', id: 'default'
  resources :categories do
    resources :books, only: :index
  end
  resources :categories, only: :show
  resources :books, only: [:index, :show]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
end
