Rails.application.routes.draw do
  resources :categories do
    resources :books, only: :index
  end
  resources :books, only: [:index, :show]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  root 'home#index'
end
