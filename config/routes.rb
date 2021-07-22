Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/welcome", to: "welcome#index"
      resources :items do
        resources :reviews
      end
    end
  end
end
