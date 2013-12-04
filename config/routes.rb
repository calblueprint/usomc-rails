USOMC::Application.routes.draw do
  get "password_resets/new"
  get "confirmations/new"
  get 'confirmed/:id', to: 'confirmations#update', as: 'confirmed'

  root to: 'static_pages#home'

  resources :users, only: [:create, :destroy, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  match '/login',  to: 'sessions#new', via: :get
  match '/logout', to: 'sessions#destroy', via: [:get, :delete]
  resources :password_resets, only: [:new, :create, :edit, :update]

  match 'profile', to: 'users#my_profile', via: :get
  match 'registration', to: 'users#new', via: :get
  match 'about', to: 'static_pages#about', via: :get
  match 'competition', to: 'static_pages#competition', via: :get
  match 'winners', to: 'static_pages#winners', via: :get
  match 'judges', to: 'static_pages#judges', via: :get
  match 'support', to: 'static_pages#support', via: :get

  match 'pieces/typeahead_search', to: 'pieces#typeahead_search', via: :get

  scope '/admin' do
    resources :pieces
    match '/', to: redirect('/admin/dashboard'), via: :get
    match 'dashboard', to: 'admins#show', via: :get
    match 'users', to: 'admins#users', as: 'admin_users', via: :get
    match 'users/:id/edit', to: 'admins#user_edit', as: 'admin_edit', via: :get
    match 'users/:id/update', to: 'admins#user_update', as: 'admin_update', via: :patch
  end

  resources :rooms
  resources :events
  resources :charges, only: [:new, :create]
  resources :events

  # API for the iPad app.
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      match 'login', to: 'sessions#login', via: :post

      match 'events/index', to: 'events#index', via: :get
      match 'events/:event_id', to: 'events#show', via: :get
      match 'events/:event_id/users', to: 'events#users', via: :get
      match 'events/:event_id/judge/:judge_id/contestant/:contestant_id/comment', to: 'events#post_comment', via: :post
      match 'events/:event_id/judge/:judge_id/contestant/:contestant_id/comments', to: 'events#comments', via: :get
      match 'events/:event_id/user/:user_id/ranking', to: 'events#post_ranking', via: :post
    end
  end
end
