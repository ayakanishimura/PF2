Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :articles do
    resources :article_comments, only:[:create, :destroy]
  end 
  
  resources :users, only:[:show, :edit, :update]

end