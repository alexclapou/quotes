# frozen_string_literal: true

Rails.application.routes.draw do
  root 'quotes#index'

  resources :quotes
  post '/rate/:id', to: 'quotes#rate', as: :rate
end
