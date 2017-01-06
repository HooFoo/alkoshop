Rails.application.routes.draw do
  scope '/cart' do
    get '/add', controller: 'cart', action: :add
    get '/remove', controller: 'cart', action: :remove
    get '/show', controller: 'cart', action: :show
  end


  scope '/shop' do
    get '/brands', controller: 'shop', action: :brands
    get '/catalog', controller: 'shop', action: :catalog
    get '/more', controller: 'shop', action: :more
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
