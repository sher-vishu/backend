Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  resources :ai_models do
    post 'toggle_availability', on: :member
  end

  get '/admin', to: 'admin#index', as: 'admin_index'
  post '/admin/toggle_availability/:id', to: 'admin#toggle_availability', as: 'toggle_availability'

  get '/users/associate_ai_models', to: 'users#associate_ai_models_form', as: 'associate_ai_models_form'
  post '/users/associate_ai_models', to: 'users#associate_ai_models', as: 'associate_ai_models'

  resources :users do
    member do
      post 'toggle_availability', to: 'users#toggle_availability'
    end
  end

  
  root to: 'home#index'
  # root to: redirect('/users/sign_in')
  # get 'home', to: 'home#index' 

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get '/logs', to: 'logs#index', as: 'logs'
  get "up" => "rails/health#show", as: :rails_health_check
end
