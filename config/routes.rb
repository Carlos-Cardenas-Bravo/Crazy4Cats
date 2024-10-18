# rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
Rails.application.routes.draw do
  resources :users, only: [:index]

  devise_for :users, controllers: {
    passwords: "users/passwords"     # personalizo el restablecimiento de contraseña
  }
  resources :posts do
    resources :comments, only: [ :create, :new, :edit, :update, :destroy ]
    resource :reaction, only: [ :create ], controller: "reactions" do
      post "create_or_update", on: :collection
    end
  end

  # rutas para que el administrador gestione los roles de los usuarios
  resources :users, only: [ :index ] do
    member do
      get "edit_role"        # ruta para que el administrador pueda ver el formulario para editar el rol
      patch "update_role"     # ruta para que el administrador actualice el rol
    end
  end

  # página estática
  get "/home", to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "posts#index"
end

# rubocop:enable Layout/SpaceInsideArrayLiteralBrackets
