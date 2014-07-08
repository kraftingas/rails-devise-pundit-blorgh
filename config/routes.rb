Rails.application.routes.draw do
  #root :to => "visitors#index"
  devise_for :users
  resources :users do
    resources :contacts
  end
  resources :posts do
    resources :comments
  end
  
  root to: "blog#index"
  #mount Blorgh::Engine, at: "/blog"
  mount Attachinary::Engine => "/attachinary"
end
