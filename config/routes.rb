# coding: utf-8
Rails.application.routes.draw do
  resources :users, only: [:new, :edit, :create, :show, :update]
  #resources :articles, only: [:new, :edit, :create, :show, :update]
  resources :tags
  #resources :channels
  resources :sessions, only: [:new, :create, :destory]
  #resources :contents

  root to: 'channels#show', id: 1, content_id: 1

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  #match '/:parent_type/:parent_id/:controller/:action', as: 'content', via: 'get'

  # create路由配置
  match 'articles/:content_id', as: 'create_article', controller: 'articles', action: 'create', via: [:post]
  match 'channels/:content_id', as: 'create_channel', controller: 'channels', action: 'create', via: [:post]
  match ':controller/:content_id', as: 'content_create', action: 'create', via: [:post]

  # update路由配置
  match 'articles/:content_id/:id', as: 'update_article', controller: 'articles', action: 'update', via: [:patch]
  match 'channels/:content_id/:id', as: 'update_channel', controller: 'channels', action: 'update', via: [:patch]
  match ':controller/:content_id/:id', as: 'content_update', action: 'update', via: [:patch]

  # new路由配置
  match 'channels/:content_id/new', as: 'new_channel', controller: 'channels', action: 'new', via: [:get]
  match 'articles/:content_id/new', as: 'new_article', controller: 'articles', action: 'new', via: [:get]
  match ':controller/:content_id/new', as: 'new_content', action: 'new', via: [:get]

  # show路由配置
  match 'articles/:content_id/:id', as: 'show_article', controller: 'articles', action: 'show', via: [:get]
  match 'channels/:content_id/:id', as: 'show_channel', controller: 'channels', action: 'show', via: [:get]
  match ':controller/:content_id/:id', as: 'show_content', action: 'show', via: [:get]

  # edit路由配置
  match 'articles/:content_id/:id/edit', as: 'edit_article', controller: 'articles', action: 'edit', via: [:get]
  match 'channels/:content_id/:id/edit', as: 'edit_channel', controller: 'channels', action: 'edit', via: [:get]
  match ':controller/:content_id/:id/edit', as: 'edit_content', action: 'edit', via: [:get]

  #match 'contents/:content_id/:controller/:action/:id', as: 'content', via: [:get, :post]
  #match ':controller/show/:id', as: 'default_show', via: [:get, :post], action: 'show'
  #match 'contents/:controller/show/:content_id', as: 'content_show', action: 'show', via: [:get, :post]
end
