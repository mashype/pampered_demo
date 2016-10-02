Rails.application.routes.draw do

  resources :locations
  resources :vendor_locations
  resources :vendors
  resources :amounts
  resources :genders
  resources :services
  resources :charges

  resources :appointments do
    resources :bookings
  end

	devise_for :users, controllers: { registrations: "registrations" }

  get 'welcome/index'
  get 'welcome/about' => 'welcome#about'
  get 'welcome/faq' => 'welcome#faq'
  get 'welcome/terms' => 'welcome#terms' 

 
  authenticated :user do
  	root 'appointments#index', as: "authenticated_root"
  end

  root  'welcome#index'

end
