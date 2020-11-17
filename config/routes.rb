Rails.application.routes.draw do
  namespace :api,  defaults: {format: :json} do
    post :sign_in, to: 'sessions#create'

    resource :user, controller: 'user'
  end
end
