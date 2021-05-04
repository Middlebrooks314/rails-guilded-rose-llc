# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/welcome', to: 'welcome#index'
      get '/items', to: 'items#index'
    end
  end
end
