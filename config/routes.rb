Rails.application.routes.draw do
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :registration, only: %i[create destroy]
      resources :user, only: %i[index show create destroy update]
      resources :profile
    end
  end
end
