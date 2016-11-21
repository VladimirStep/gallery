Rails.application.routes.draw do

  root to: 'pictures#index'
  devise_for :users

  resources :categories, param: :category_name, only: [:index, :show] do
    get ':id', to: 'pictures#show', as: 'picture'
  end
  
  resources :comments, only: [:create, :index]
  resources :likes, only: [:create, :destroy]
  resources :events, only: [:index]

  get 'events/user_comments/:id', to: 'events#user_comments', as: 'user_comments'
  get 'events/user_likes/:id', to: 'events#user_likes', as: 'user_likes'
  get 'events/user_navigation/:id', to: 'events#user_navigation', as: 'user_navigation'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
