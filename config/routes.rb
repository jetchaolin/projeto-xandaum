Rails.application.routes.draw do
  get "vote/index"
  get "parties/index"
  get "deputy/index"
  get "event/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
  resources :home, only: :index
  resources :deputies, only: [ :index, :show, :edit ]
  resources :events, only: [ :index, :show ]
  resources :parties, only: [ :index, :show ]
  resources :votes, only: [ :index, :show ]
  # get "home/detailed_events_list", to: "home#detailed_events_list"
  # get "home/show", to: "home#show"
  # get "home/date_select", to: "home#date_select"
  # get "home/parties_list", to: "home#parties_list"
  get "home/votes", to: "home#votes"
  get "home/links", to: "home#links"
  get "home/about", to: "home#about"
end
