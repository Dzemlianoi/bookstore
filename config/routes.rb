Rails.application.routes.draw do
  root to: 'categories#show', id: 'default'
  resources :categories do
    resources :books, only: :index
  end
  resources :categories, only: :show
  resources :books, only: [:index, :show]
  resources :books do
    resources :reviews, only: :create
  end
  resources :addresses
  resources :order_items, only: [:index, :create, :destroy, :update]
  resources :coupons, only: [:create, :destroy, :update]
  resources :orders
  resources :order_steps, only: [:show, :update]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
end
