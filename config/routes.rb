Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :users, only: :show do
    resources :goals
    resources :connections
    resources :preferences, except: [:index]
  end

  resources :users, only: :index

  resources :communities

  post '/motimates', to: 'connections#accept', as: :accept

  root 'welcome#home'
end
