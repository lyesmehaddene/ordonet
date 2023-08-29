Rails.application.routes.draw do
  get 'ordonnances/show'
  get 'ordonnances/new'
  get 'ordonnances/create'
  get 'ordonnances/edit'
  get 'ordonnances/update'
  get 'appointments/index'
  get 'appointments/show'
  get 'appointments/create'
  get 'appointments/new'
  get 'appointments/update'
  get 'appointments/edit'
  get 'appointments/destroy'
  get 'doctors/show'
  get 'doctors/create'
  get 'doctors/new'
  get 'doctors/update'
  get 'doctors/edit'
  get 'doctors/destroy'
  get 'patients/index'
  get 'patients/show'
  get 'patients/new'
  get 'patients/create'
  get 'patients/update'
  get 'patients/edit'
  get 'patients/destroy'
  get 'users/create'
  get 'users/new'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'

end
