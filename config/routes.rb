Rails.application.routes.draw do 
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # 顧客用
  get  "/signup", to: "public/registrations#new"
  post "/signup", to: "public/registrations#create"


  scope module: :public do
    root to: "homes#top"
    resource :session, only: [:new, :create, :destroy]
    resources :passwords, param: :token
  end

  # 管理者用
  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
  end
end