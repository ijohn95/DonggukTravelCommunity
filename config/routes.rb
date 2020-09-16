Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :my_page
  resources :posts, except: [:show] do
    post "/like", to: "likes#like_toggle"
    post "/dislike", to: "dislikes#dislike_toggle"
    resources :comments, only: [:create, :destroy]
  end
  

  resources :follows, only: [:create, :destroy]
  # 해시태그
  get '/posts/hashtag/:name', to: 'posts#hashtags'
end