Rails.application.routes.draw do
  get '/signup', to: 'users#new'  #新規ユーザー登録
  
  get '/login', to: 'sessions#new'  #ログイン画面
  post '/login', to: 'sessions#create'  #ログイン画面
  delete '/logout', to: 'sessions#destroy' 
  root 'top_page#top'
  
  
  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
    end
    resources :attendances, only: [:update]
  end
end
