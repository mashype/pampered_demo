Rails.application.routes.draw do 

  resources :coupons
  resources :durations
  
  resources :features
  resources :amounts
  resources :charges
  resources :genders
  resources :locations
  resources :messages, only: [:new, :create]
  resources :services
  resources :vendor_types
  resources :vendor_documents
  resources :vendor_features
  resources :vendor_licenses
  resources :vendor_locations 
  resources :vendor_services

  resources :blogposts do 
    resources :blogcomments
  end

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

  resources :vendors, except: [:index] do
    resources :reviews, except: [:show, :index]  
    collection do 
      get 'massage'
    end  
  end

  resources :appointments do
    collection do 
      get 'aptsearch'
      get 'aptfilter'
    end
    resources :bookings, except: [:index]
  end

	devise_for :users, controllers: { registrations: "registrations" }
  

  get 'vendors' => 'welcome#vendors'
  get 'welcome/index'
  get 'welcome/about' => 'welcome#about'
  get 'welcome/faq' => 'welcome#faq'
  get 'welcome/terms' => 'welcome#terms' 
  get 'welcome/vendors' => 'welcome#vendors' 
  get 'welcome/mail' => 'welcome#mail' 
 
  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]

  authenticated :user do
  	root 'appointments#aptfilter', as: "authenticated_root"
  end

  root  'welcome#index'

end
