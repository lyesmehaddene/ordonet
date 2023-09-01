Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :appointments, only: %i[index show create new update edit] do
    resources :ordonnances, only: %i[show create new]
  end

  resources :doctors, only: %i[new create edit] do
    resources :patients, only: %i[index show create new]
  end

  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  
  resources :patients do
  collection do
    get 'search'
  end
end
end
