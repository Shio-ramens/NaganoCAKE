
Rails.application.routes.draw do

  # 顧客用
  get  "customers/sign_up", to: "public/registrations#new"
  post "customers/sign_up", to: "public/registrations#create"


  scope module: :public do
    root to: "homes#top"
    get "about", to: "homes#about"
    resource :session, only: [:new, :create, :destroy]
    resources :passwords, param: :token
  end

  # 管理者用
  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
  end
end