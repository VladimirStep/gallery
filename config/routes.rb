Rails.application.routes.draw do

  root to: 'pictures#index'
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :categories, param: :category_name, only: [:index, :show] do
    get ':id', to: 'pictures#show', as: 'picture'
  end
  
  resources :comments, only: [:create, :index]
  resources :likes, only: [:create, :destroy]
  resources :events, only: [:index]

  get 'events/user_comments/:id', to: 'events#user_comments', as: 'user_comments'
  get 'events/user_likes/:id', to: 'events#user_likes', as: 'user_likes'
  get 'events/user_navigation/:id', to: 'events#user_navigation', as: 'user_navigation'
  get 'events/user_sign_in/:id', to: 'events#user_sign_in', as: 'user_sign_in'
  get 'events/user_sign_out/:id', to: 'events#user_sign_out', as: 'user_sign_out'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
