# coding: utf-8
Rails.application.routes.draw do
  resources :users, only: [:new, :edit, :create, :show, :update]
  resources :items, only: [:new, :edit, :create, :show, :update]
  resources :tags
  resources :channels
  resources :sessions, only: [:new, :create, :destory]

  root to: 'channels#show'

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/:parent_type/:parent_id/:controller/:action', as: 'content', via: 'get'
  match ':controller/:action', via: [:get, :post]
end
