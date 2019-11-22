Rails.application.routes.draw do
  devise_for :users, controllers: {
            sessions: "users/sessions",
            registrations: "users/registrations",
            omniauth_callbacks: "users/omniauth_callbacks",
          }

  resources :users, only: :show do
    resources :goals
    resources :connections
    resources :preferences, except: [:index]
  end

  resources :users, only: :index

  resources :communities, only: [:show, :index]

  post "/motimates", to: "connections#accept", as: :accept

  get "connections/:id", to: "connections#show"
  get "users/:id/motimates", to: "motimates#motimates_for_user"

  delete "/users/:id/delete_avatar", to: "users#delete_avatar", as: :delete_avatar

  root "welcome#home"
end
