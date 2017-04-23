# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'categories#default'
  resources :categories do
    get 'default', on: :member
    resources :books, only: :index
  end
  resources :books do
    resources :reviews, only: :create
  end
  resources :addresses
  resources :order_items, except: :show
  resources :coupons, only: :create
  resources :orders do
    get 'confirm', on: :member
  end
  resources :order_steps, only: %i(show update)

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
