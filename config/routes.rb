# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/welcome', to: 'welcome#index'
    end
  end
end
