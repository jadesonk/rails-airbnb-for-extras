Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "jobs", to: "jobs#index"
  get "jobs/:id", to: "jobs#show", as: :job
  get "performers", to: "users#index"
  get "performers/:id", to:"users#show", as: :performer
  get "performers/:id/edit", to:"users#edit", as: :edit_performer
  patch "performers/:id", to:"users#update"
end
