Rails.application.routes.draw do
  root 'frontend#index'
  get '/', controller: 'frontend', action: :index
  get '/profile', controller: 'frontend', action: :profile

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
