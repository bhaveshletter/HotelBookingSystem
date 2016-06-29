Rails.application.routes.draw do
  devise_for :users, :skip => [:sessions, :registration, :password]

  # API configurations
  namespace :api, defaults: { format: :json }, path: '/' do
    # Resources listing here
    root 'home#welcome'
    resources :categories, :only => [:index]
    resources :sessions, :only => [:create]
    resources :users, :only => [:index, :create] do
      resources :bookings, :only => [:index, :create, :update]
    end
    get 'search' => 'rooms#search'
    match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all
  end  
end
