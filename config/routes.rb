Rails.application.routes.draw do
  resources :fibs, only: [:index, :show, :new, :destroy]
  namespace :api do
    namespace :v1 do
      resources :fibs, only: [:index, :show, :create] do
        member do
          post :check_item_exist
          post :check_items_equality
        end
      end
    end
  end

  root to: 'fibs#index'
end
