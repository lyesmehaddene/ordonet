Rails.application.routes.draw do
  resources :appointments, only: %i[index show create new] do
    resources :ordonnances, only: %i[show create new]
  end

  resources :doctor, only: [] do
    resources :patients, only: %i[index show create new]
  end

  root to: 'pages#home'
end
