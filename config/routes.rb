Rails.application.routes.draw do
  resources :products, only: [:index] do
    collection { post :upload }
  end
end
