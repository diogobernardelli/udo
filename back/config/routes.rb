Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items do
        collection do
          post :reorder
        end
      end

      resources :settings, only: [] do
        collection do
          post :toogle_alert
        end
      end
    end
  end

  post "refresh", controller: :refresh, action: :create
  post "signin", controller: :signin, action: :create
  post "signup", controller: :signup, action: :create
  delete "signin", controller: :signin, action: :destroy
end
