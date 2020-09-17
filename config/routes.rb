Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "jobs", to: "jobs#index"
  get "jobs/new", to: "jobs#new"
  post "jobs", to: "jobs#create"
  get "jobs/:id", to: "jobs#show", as: :job

  resources :jobs do
    resources :roles, only: [:new,:create]
  end

  resources :roles do
    resources :auditions, only: [:new, :create]
  end

  get "performers", to: "users#index"
  get "performers/:id", to:"users#show", as: :performer
  get "performers/:id/edit", to:"users#edit", as: :edit_performer
  patch "performers/:id", to:"users#update"


  patch "auditions/:id/approve", to:"auditions#approve", as: :approve_audition
  patch "auditions/:id/reject", to:"auditions#reject", as: :reject_audition
end
