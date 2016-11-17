Rails.application.routes.draw do
  get 'comments/create'

  devise_for :users
  root to: 'pictures#index'

  resources :categories, param: :category_name, only: [:index, :show] do
    get ':id', to: 'pictures#show', as: 'picture'
  end
  resources :comments, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
