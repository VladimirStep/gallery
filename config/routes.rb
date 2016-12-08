Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'pictures#index'
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :categories, param: :category_name, only: [:index, :show] do
    get ':id', to: 'pictures#show', as: 'picture'
  end
  
  resources :comments, only: [:create, :index]
  resources :likes, path: '/:picture_id/likes', only: [:create, :destroy]
  resources :events, only: [:index]

  get 'events/:id/comments', to: 'events#user_comments', as: 'user_comments'
  get 'events/:id/likes', to: 'events#user_likes', as: 'user_likes'
  get 'events/:id/navigation', to: 'events#user_navigation', as: 'user_navigation'
  get 'events/:id/user_sign_in', to: 'events#user_sign_in', as: 'user_sign_in'
  get 'events/:id/user_sign_out', to: 'events#user_sign_out', as: 'user_sign_out'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
