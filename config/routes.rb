require 'resque/server'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'static_pages#index'
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :categories, param: :category_name, only: [:index, :show] do
    get ':id', to: 'pictures#show', as: 'picture'
  end
  resources :pictures, only: [:index]
  resources :comments, only: [:index]
  post '/:picture_id/comments', to: 'comments#create', as: 'create_comment'
  resources :likes, path: '/:picture_id/likes', only: [:create, :destroy]
  resources :events, only: [:index]
  resources :subscriptions, path: '/:category_id/subscriptions', only: [:create, :destroy]

  resources :chat_rooms, only: [:new, :create, :index, :show]

  get 'events/:id/comments', to: 'events#user_comments', as: 'user_comments'
  get 'events/:id/likes', to: 'events#user_likes', as: 'user_likes'
  get 'events/:id/navigation', to: 'events#user_navigation', as: 'user_navigation'
  get 'events/:id/user_sign_in', to: 'events#user_sign_in', as: 'user_sign_in'
  get 'events/:id/user_sign_out', to: 'events#user_sign_out', as: 'user_sign_out'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount Resque::Server.new, :at => '/resque'
  mount ActionCable.server, :at => '/cable'
end
