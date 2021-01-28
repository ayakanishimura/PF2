Rails.application.routes.draw do
  get '/search' => 'search#search'
  get '/genre_search' => 'search#genre_search'

  devise_for :users

  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :articles do
    resource :favorites, only: [:create, :destroy]
    resources :article_comments, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    get :myindex, on: :member, to: 'articles#myindex'
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'sessions#new_guest'
  end
end
