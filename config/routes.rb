Rails.application.routes.draw do
  post 'users/edit'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  root 'frontend#index'
  get '/', controller: 'frontend', action: :index
  get '/profile', controller: 'frontend', action: :profile
  get '/shop', controller: 'frontend', action: :shop
  get '/template/:name', controller: 'frontend', action: 'template'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
