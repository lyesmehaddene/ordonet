Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :appointments, only: %i[index show create new] do
    resources :ordonnances, only: %i[show create new]
  end

  resources :doctors, only: %i[new create edit] do
    resources :patients, only: %i[index show create new]
  end

  resources :appointments, only: [] do
    resources :ordonnances, only: %i[show create new] do
      resources :ordo_medications, only: %i[new create]
    end
  end

  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
end
