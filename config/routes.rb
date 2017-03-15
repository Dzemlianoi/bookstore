Rails.application.routes.draw do
  root to: 'categories#show', id: Category.default_id
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
  resources :coupons, only: :create
  resources :orders do
    member do
      get 'confirm'
    end
  end
  resources :order_steps, only: [:show, :update]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
end
