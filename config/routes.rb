Rails.application.routes.draw do

  resources :genders
  resources :services
  resources :appointments

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
