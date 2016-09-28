Rails.application.routes.draw do

  devise_for :users
  resources :appointments


  get 'welcome/index'
 
  authenticated :user do
  	root 'appointments#index', as: "authenticated_root"
  end

  root  'welcome#index'

end
