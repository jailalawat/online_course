# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboard#index'
  resources :courses, only: %i(index show)
  resources :categories, only: %i(index)
end
