Rails.application.routes.draw do
  root 'pictures#index'

  resources :categories, param: :category_name, only: [:index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
