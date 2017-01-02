# coding: utf-8
Rails.application.routes.draw do
    resources :users, only: [:new, :edit, :create, :show, :update]
    resources :sessions, only: [:new, :create, :destory]

    root to: 'channels#show', id: 1, content_type: 'Content', content_id: 1

    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    match '/signout', to: 'sessions#destroy', via: 'delete'
    match '/help', to: 'static_pages#help', via: 'get'
    match '/about', to: 'static_pages#about', via: 'get'
    match '/contact', to: 'static_pages#contact', via: 'get'

    %w(contents).each do |controller|
        match "#{controller}/:id", controller: controller, action: 'destroy', via: [:delete]
    end

    %w(channels articles).each do |controller|
        match ":content_type/:content_id/#{controller}/:id/edit", controller: controller, action: 'edit', via: [:get]
        match ":content_type/:content_id/#{controller}/new", controller: controller, action: 'new', via: [:get]
        match ":content_type/:content_id/#{controller}/:id", controller: controller, action: 'show', via: [:get]
        match ":content_type/:content_id/#{controller}/:id", controller: controller, action: 'update', via: [:patch, :put]
        match ":content_type/:content_id/#{controller}/:id", controller: controller, action: 'destroy', via: [:delete]
        match ":content_type/:content_id/#{controller}", controller: controller, action: 'index', via: [:get]
        match ":content_type/:content_id/#{controller}", controller: controller, action: 'create', via: [:post]
    end
end
