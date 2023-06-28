Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do

    get 'top' => 'homes#top', as: 'top'
    resources :items
    resources :genres, only: [:edit, :create, :update, :index]
    resources :customers, only: [:edit, :show, :update, :index]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]

  end

  # skipを使うことでデフォルトで作成されるパスワード変更画面を削除
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do

    root 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    resources :items, only: [:show, :index]
    resources :deliveries, only: [:index, :edit, :create, :update, :destroy]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    end
    resources :customers, only: [:show, :update] do
      get 'information/edit' => 'customers#edit', as: 'edit_information'
      get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
      patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    end
    resources :orders, only: [:new, :show, :index, :create] do
      post 'orders/confirm' => 'orders#confirm'
      get 'orders/thanks' => 'orders#thanks', as: 'thanks'
    end

  end

end
