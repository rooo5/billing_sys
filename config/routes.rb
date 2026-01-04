Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "purchases#new"
  resources :purchases, only: [ :new, :create, :show, :index ]
end
