Rails.application.routes.draw do
  root to: 'categories#show', id: 'default'
  resources :categories do
    resources :books, only: :index
  end
  resources :categories, only: :show
  resources :books, only: [:index, :show]
  resources :cart, only: [:index, :update]
  resources :books do
    resources :reviews, only: :create
  end
  resource :addresses
  resource :order_item, only: [:create, :destroy]
  resources :order


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
end
