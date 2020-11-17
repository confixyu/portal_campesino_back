Rails.application.routes.draw do
  namespace :api,  defaults: {format: :json} do
    post :sign_in, to: 'sessions#create'

    resource :user, controller: 'user'
    resources :products, controller: 'products'
    resources :purchases, controller: 'purchases'
  end
end
