Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do

    resources :items, only: [:index, :show]
    resources :cart_items, only:[:create, :index, :destroy, :update]do
      collection do
        delete 'destroy_all'
      end
    end

    get '/about' => "homes#about", as: "about"
    get '/customers/mypage' => "customers#show", as: 'mypage'
    get '/customers/infomation/edit' => "customers#edit", as: 'edit_infomation'
    patch '/customers/infomation' => "customers#update", as: 'update_infomation'
    get '/customers/unsubscribe' => "customers#unsubscribe", as: 'unsubscribe'
    patch '/customers/withdraw' => "customers#withdraw", as: 'withdraw'

    get  '/orders/complete' => "orders#complete", as: "order_complete"

    resources :orders, only:[:create, :new, :index, :show]

    post '/orders/confirm' => "orders#confirm", as: "order_confirm"


    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end



  namespace :admin do
    get '/' => "homes#top", as:"top"
    resources :items, only:[:index, :new, :create, :show, :edit, :update,]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :order_details
    resources :orders
    resources :customers

    get '/admin' => "homes#top"
  end





  # For details on the DSgit L available within this file, see https://guides.rubyonrails.org/routing.html
end
