Rails.application.routes.draw do
  #root :to => "visitors#index"
  
  localized do
  #scope "/:locale" do
    devise_for :users
    resources :users do
      resources :contacts
    end
    resources :posts do
      resources :comments
    end
    
    root to: "blog#index"
  end
    
    
  #end
  
  
  #mount Blorgh::Engine, at: "/blog"
  mount Attachinary::Engine => "/attachinary"
end
