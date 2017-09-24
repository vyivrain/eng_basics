Rails.application.routes.draw do
  resources :fibs, except: [:index, :edit, :update] do
    member do
     post :check_item_exist
     post :check_items_equality
    end
  end

  root to: 'fibs#index'
end
