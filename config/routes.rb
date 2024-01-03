Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  # TODO: topページを作成する
  # root "static_pages#home"
  root "review_requests#index"

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "logout" => "user_sessions#destroy", :as => :logout
  resource :profile, only: [:show, :edit, :update]
  resources :review_requests, only: [:index, :new, :create]
  resources :groups do
    resources :group_members, only: [:create, :destroy], as: :members
  end
  resources :group_member_forms, only: [:create, :destroy]
  resources :users do
    resource :activate, only: [:create, :destroy], module: :users
  end
  resource :fetch_mattermost_id, only: [:create], module: :users
end
