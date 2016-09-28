Rails.application.routes.draw do

  resources :services
  resources :appointments

	devise_for :users, controllers: { registrations: "registrations" }

  get 'welcome/index'
 
  authenticated :user do
  	root 'appointments#index', as: "authenticated_root"
  end

  root  'welcome#index'

end
