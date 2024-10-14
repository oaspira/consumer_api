Rails.application.routes.draw do
  resources :products, only: [:index] do
    collection do
      post :upload
    end
  end

  # TODO, Remove this section after configure session control
  Sidekiq::Web.use Rack::Session::Cookie, secret: Rails.application.credentials.secret_key_base
  mount Sidekiq::Web => '/sidekiq'
end
