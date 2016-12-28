Rails.application.routes.draw do

  resources :amounts
  resources :charges
  resources :genders
  resources :locations
  resources :messages, only: [:new, :create]
  resources :services
  resources :vendor_types
  resources :vendor_documents
  resources :vendor_licenses
  resources :vendor_locations 
  resources :vendor_services

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end

  resources :vendors do
    resources :reviews, except: [:show, :index]    
  end

  resources :appointments do
    collection do 
      get 'aptsearch'
      get 'aptfilter'
    end
    resources :bookings, except: [:index]
  end

	devise_for :users, controllers: { registrations: "registrations" }
  

  get 'welcome/index'
  get 'welcome/about' => 'welcome#about'
  get 'welcome/faq' => 'welcome#faq'
  get 'welcome/how' => 'welcome#how'
  get 'welcome/terms' => 'welcome#terms' 
  get 'welcome/vendors' => 'welcome#vendors' 

 
  authenticated :user do
  	root 'appointments#index', as: "authenticated_root"
  end

  root  'welcome#index'

end
