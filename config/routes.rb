Rails.application.routes.draw do
  get '/search' => 'search#search'
  get '/genre_search' => 'search#genre_search'
  devise_for :users
  root to: 'homes#top'
  resources :articles do
    resource :favorites, only:[:create, :destroy]
    resources :article_comments, only:[:create, :destroy]
  end

  resources :users, only:[:show, :edit, :update]

end