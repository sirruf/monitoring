# frozen_string_literal: true

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :sites do
    resources :events, only: [:index]
  end
end
