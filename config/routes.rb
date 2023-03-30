Rails.application.routes.draw do
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :registration, only: %i[create destroy]
      resource :user, only: %i[show create destroy]
      resource :section
    end
  end
end
