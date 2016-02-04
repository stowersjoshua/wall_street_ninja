Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'landings/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords", omniauth_callbacks: "users/omniauth_callbacks"}, skip: [:sessions, :registrations]

  devise_scope :user do
    get    "login"   => "users/sessions#new",         as: :new_user_session
    post   "login"   => "users/sessions#create",      as: :user_session
    delete "signout" => "users/sessions#destroy",     as: :destroy_user_session
    
    get    "signup"  => "users/registrations#new",    as: :new_user_registration
    post   "signup"  => "users/registrations#create", as: :user_registration
    put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
  end

  get "details" => "users#user_profile",   as: :user_profile_users
  resources :users, only: [:update]

  resources :academies do
    resources :assignments
    collection do
      get :academies_lists
      get :registration_list
    end
    member do
      get :send_joining_request
      get :approve_registration_request
      delete :remove_registration_request
    end
  end


  resources :portfolios do 
    member do 
      get :fetch_current_price
      get :change_status
    end
  end

  resources :companies do
    resources :purchases
    resources :sales 
  end
  
  resources :articles 
  resources :landings, path: "/" do
    collection do
      post :search  
    end
  end

  root 'landings#index'
end
