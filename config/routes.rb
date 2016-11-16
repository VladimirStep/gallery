Rails.application.routes.draw do
  devise_for :users
  root to: 'pictures#index'

  resources :categories, param: :category_name, only: [:index, :show] do
    # OPTIMIZE Avoid dubling. Add strict link with the only one category name to the picture.
    get ':id', to: 'pictures#show', as: 'picture'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
