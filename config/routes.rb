Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication
  post '/auth/signup', to: 'authentication#signup'
  post '/auth/login', to: 'authentication#login'

  # Users
  # Since AuthenticationController handles user updates/deletes, we map these manually
  # or we could use resources :users, only: [:update, :destroy], controller: 'authentication'
  put '/users/:id', to: 'authentication#update'
  delete '/users/:id', to: 'authentication#destroy'

  # Blogs & Nested Resources
  resources :blogs do
    resources :contents, only: [:index, :create, :update, :destroy]
    resources :faqs, only: [:index, :create, :update, :destroy]
  end

  # Operations & Nested Resources
  resources :operations do
    resources :contents, only: [:index, :create, :update, :destroy]
    resources :faqs, only: [:index, :create, :update, :destroy]
  end

  # Standard Resources
  resources :galleries
  resources :videos

  # Global FAQs (mapped to specific non-nested actions)
  # Based on FaqsController implementation (index_without_plog, etc.)
  get '/faqs', to: 'faqs#index_without_plog'
  post '/faqs', to: 'faqs#create_without_plog'
  put '/faqs/:id', to: 'faqs#update_without_plog'
  delete '/faqs/:id', to: 'faqs#delete_without_plog'

end
