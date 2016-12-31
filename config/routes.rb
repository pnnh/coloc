# coding: utf-8
Rails.application.routes.draw do
  resources :users, only: [:new, :edit, :create, :show, :update]
  resources :sessions, only: [:new, :create, :destory]
  resources :contents, only: [] do
      resources :channels, :articles
  end

  root to: 'channels#show', id: 1, content_id: 1

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

    # match ':controller/:content_id/:id/edit', action: 'edit', via: [:get]
    # match ':controller/:content_id/new', action: 'new', via: [:get]
    # match ':controller/:content_id/:id', action: 'show', via: [:get]
    # match ':controller/:content_id', action: 'index', via: [:get]
    # match ':controller/:content_id/', action: 'create', via: [:post]
    # match ':controller/:content_id/:id', action: 'update', via: [:patch, :put]
    # match ':controller/:content_id/:id', action: 'destroy', via: [:delete]

end
