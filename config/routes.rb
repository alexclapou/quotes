# frozen_string_literal: true

Rails.application.routes.draw do
  root 'quotes#index'

  resources :quotes
  post '/filter', to: 'quotes#filter', as: :filter
end
