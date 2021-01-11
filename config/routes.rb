Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :articles do
    resource :favorites, only:[:create, :destroy]
    resources :article_comments, only:[:create, :destroy]
  end

  resources :users, only:[:show, :edit, :update]

end