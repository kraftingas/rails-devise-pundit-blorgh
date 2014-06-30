Rails.application.routes.draw do
  root :to => "visitors#index"
  devise_for :users
  resources :users
  resources :posts do
    resources :comments
  end
  #mount Blorgh::Engine, at: "/blog"
end
