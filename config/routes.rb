Rails.application.routes.draw do

  
  resources :vendor_types
  resources :vendor_documents
  resources :vendor_licenses
  resources :vendor_services
  resources :locations
  resources :vendor_locations
  resources :amounts
  resources :genders
  resources :services
  resources :charges

  resources :vendors do
    resources :reviews, except: [:show, :index]    
  end

  resources :appointments do
    resources :bookings, except: [:index]
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
