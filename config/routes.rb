Rails.application.routes.draw do
  scope '/shop' do
    get '/brands', controller: 'shop', action: :brands
    get '/template/:name', controller: 'shop', action: :template
  end


  get '/', controller: 'frontend', action: :index
  get '/profile', controller: 'frontend', action: :profile
  get '/shop', controller: 'frontend', action: :shop
  get '/template/:name', controller: 'frontend', action: 'template'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  root 'frontend#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
