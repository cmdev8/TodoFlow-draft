Todo::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  get "home/index"
  
  resources :list_items do
    member do 
      get :done
      get :set_deadline
      get :start
      get :timer_start
      get :timer_stop
    end
  end

  resources :lists

  devise_for :users
  root 'home#index'
end
