Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "concerts#index"

  resources :concerts do
    resources :shared_experiences
  end

  resources :artists
  resources :venues

  mount ActionCable.server => '/cable'
end
