
Rails.application.routes.draw do

  namespace :public do
    get "addresses/index"
  end

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
    get "customers/information/edit", to: "customers#edit"
    patch "customers/information", to: "customers#update"

    get "customers/unsubscribe", to: "customers#unsubscribe"
    patch "customers/withdraw", to: "customers#withdraw"

    resources :customers, only: [:show, :edit, :update]
    resources :passwords, param: :token
    resources :items, only: [:index, :show]

    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  # 管理者用
  namespace :admin do
    get "homes/top"
    get    'sign_in',  to: 'sessions#new',     as: :sign_in
    post   'sign_in',  to: 'sessions#create'
    delete 'sign_out', to: 'sessions#destroy', as: :sign_out
   
    resources :genres, only: [:index, :create, :edit, :update]

    root to: 'homes#top'
  end
end