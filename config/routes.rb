# coding: utf-8
Rails.application.routes.draw do
    resources :users, only: [:new, :edit, :create, :show, :update]
    resources :sessions, only: [:new, :create, :destory]
    resources :channels do
        resources :articles
    end
    resources :articles
    resources :channel_follows

    root to: 'static_pages#index'

    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    match '/signout', to: 'sessions#destroy', via: 'delete'
    match '/help', to: 'static_pages#help', via: 'get'
    match '/about', to: 'static_pages#about', via: 'get'
    match '/contact', to: 'static_pages#contact', via: 'get'

end
