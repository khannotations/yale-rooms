Rooms::Application.routes.draw do

  root :to => 'welcome#index'
  match 'welcome' => "welcome#welcome"
  match 'user' => "users#me"

  resources :organizations do
    resources :events
  end

  match 'rooms/all/:date/:period' => "rooms#index"
  match 'rooms/:name/:date/:period' => "rooms#show"
end
