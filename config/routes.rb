Rails.application.routes.draw do
  root 'pictures#index'

  get 'pictures/index'

  get 'categories/index'

  get 'categories/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
