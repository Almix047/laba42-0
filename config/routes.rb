# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: :index do
    collection do
      post 'email_exists'
    end
  end

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # API namespace, for JSON requests at /api/sign_[in|out]
  namespace :api do
    devise_for :users, defaults: { format: :json },
                     class_name: 'ApiUser',
                           skip: [:registrations, :invitations,
                                  :passwords, :confirmations,
                                  :unlocks, :omniauth_callbacks],
                           path: '',
                     path_names: { sign_in: 'login',
                                  sign_out: 'logout' }
    devise_scope :user do
      get 'login', to: 'devise/sessions#new'
      delete 'logout', to: 'devise/sessions#destroy'
    end

    namespace :v1 do
      resources :projects, only: %i[index show create update destroy]
      resources :applies, only: %i[create destroy]
      post 'applies(/:id)', to: 'applies#appointment'
      resources :comments, only: %i[create destroy]
    end

  end

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users, skip: :omniauth_callbacks, controllers: { confirmations: 'confirmations' }
    root to: 'home#index'

    get 'my_projects', to: 'home#my_projects'

    resources :projects do
      get 'applies'
      post 'applies', to: 'applies#appointment'
    end

    post 'implementation', to: 'applies#implementation'

    resources :comments
    resources :applies
    resource :profile, controller: 'profile', only: %i[edit update] do
      post 'update_role'
      get 'edit_role'
      get 'customer_setup_info'
      get 'developer_setup_info'
      get 'customer_edit'
      get 'developer_edit'
      get 'cabinet'
    end
  end
end
