Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v0 do
      post :sign_up, to: 'registration#create'
      post :sign_in, to: 'sessions#create'
    end
  end
end
