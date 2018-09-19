Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :shops
  resources :items

  post 'signin', to: 'shop_authentication#authenticate'
  post 'signup', to: 'shop_authentication#signup'
end
