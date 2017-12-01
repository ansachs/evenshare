Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  root to: "concerts#index"

  # post '/:concert_id/media', to: 'shared_experiences#add_media'
  get '/concerts/:concert_id/shared_experiences/media_search', to: 'shared_experiences#media_search'

  get '/concerts/:concert_id/shared_experiences/tweet_feed', to: 'shared_experiences#tweet_feed'

  resources :concerts do
    resources :shared_experiences
  end

  resources :user do
    resources :media_links
  end

  resources :artists
  resources :venues
  

  mount ActionCable.server => '/cable'
end
