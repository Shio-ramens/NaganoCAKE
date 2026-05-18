
Rails.application.routes.draw do

  # 顧客用
  get  "customers/sign_up", to: "public/registrations#new"
  post "customers/sign_up", to: "public/registrations#create"

  get "customers/sign_in", to: "public/sessions#new"
  post "customers/sign_in", to: "public/sessions#create"
  delete "customers/sign_out",to: "public/sessions#destroy"

  scope module: :public do
    root to: "homes#top"
    get "about", to: "homes#about"
    get "customers/my_page", to: "customers#show"
    resource :customer, only: [:show, :edit, :update]
    resources :passwords, param: :token
    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
  end

  # 管理者用
  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
  end
end