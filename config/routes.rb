Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # resources :registration, only: %i[create destroy]
      resource :user, only: %i[show]
      # resource :session, only: %i[create destroy]
    end
  end
end
