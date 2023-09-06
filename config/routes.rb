Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :appointments, only: %i[index show create new update edit] do
    resources :ordonnances, only: %i[show create new] do
      get :create_pdf, on: :member
      get 'generate_qrcode', on: :member, to: 'ordonnances#generate_qrcode'
      post :send_email, on: :member
    end
  end

  resources :doctors, only: %i[new create edit] do
    resources :patients, only: %i[index show create new]
  end

  resources :appointments, only: [] do
    resources :ordonnances, only: %i[show create new] do
      resources :ordo_medications, only: %i[new create]
    end
  end

  resources :ordonnances, only: [] do
    post 'create_pdf', on: :member
  end

  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard_new'

  resources :patients do
    collection do
      get 'search'
      get 'search_by_day'
    end
  end
end
