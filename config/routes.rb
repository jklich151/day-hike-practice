Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/trips", to: "trips#index"
  get "/trips/:id", to: "trips#show"
  get "/trails/:id", to: "trails#show"
  delete "/trail_trips/:trip_id/:trail_id", to: "trail_trips#destroy"
end
