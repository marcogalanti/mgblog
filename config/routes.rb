Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users do
    collection do
      post 'search'
      get 'search'
    end
  end

  devise_scope :user do
    post "/users/sign_out" => 'devise/sessions#destroy'
    post "/users/sign_in" => 'devise/sessions#create'
  end

end
