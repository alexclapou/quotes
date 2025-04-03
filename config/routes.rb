# frozen_string_literal: true

Rails.application.routes.draw do
  root 'quotes#index'
  get 'cancel_quote', to: 'quotes#cancel'
  resources :quotes
end
