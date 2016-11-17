Rails.application.routes.draw do
  root to: 'pictures#index'
  devise_for :users

  resources :categories, param: :category_name, only: [:index, :show] do
    get ':id', to: 'pictures#show', as: 'picture'
  end
  
  resources :comments, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
