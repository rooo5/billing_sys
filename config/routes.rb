Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "purchases#new"
  resources :purchases, only: [ :new, :create, :show, :index ]
  get "customer_purchases", to: "purchases#customer_purchases"
  get "purchase_items/:id", to: "purchases#purchase_items"
end
