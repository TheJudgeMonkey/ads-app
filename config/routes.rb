# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ru/ do
    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }

    root to: 'advertisements#index'

    resources :advertisements do
      scope module: 'advertisements' do
        resources :delete_file, only: %i[destroy]
      end
    end

    resources :categories

    namespace :moderations do
      resources :advertisements, only: %i[index show update destroy]
    end

    resources :users
  end
end
