Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/welcome", to: "welcome#index"
      resources :items, only: [:index, :show, :create] do
        resources :reviews, only: [:index]
      end
    end
  end
end
