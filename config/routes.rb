# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'advertisements#index'

  resources :advertisements do
    scope module: 'advertisements' do
      resources :delete_file, only: %i[destroy]
    end
  end

  resources :users
end
