Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :appointments, only: %i[index show create new] do
    resources :ordonnances, only: %i[show create new]
  end

  resources :doctor, only: [] do
    resources :patients, only: %i[index show create new]
  end

  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
end
