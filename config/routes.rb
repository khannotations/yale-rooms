Rooms::Application.routes.draw do

  root :to => 'welcome#index'
  resources :organizations do
    resources :events
  end
end
