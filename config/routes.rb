Rails.application.routes.draw do
  devise_for :users
  resources :projects do
    resources :comments, only: [:create , :new]
    resources :status_changes, only: [:create]

    member do
      patch :change_status
    end
  end

  root 'projects#index'
end
