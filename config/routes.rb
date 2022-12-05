Rails.application.routes.draw do
  namespace :ativo_pge do
    resources :admins
    resources :ativos
    resources :users
    resources :areas
    resources :subareas
    resources :acquisitions
    resources :deposits, only: %i[index edit update]
    resources :bonds do
      collection do
        match :term_responsibility_asset, via: %i[get post]
        get 'term_responsibility_asset'
        post 'term_responsibility_asset'
      end
    end
    get '/bonds/history/:id', to: 'bonds#history', as: 'history'
  end

  namespace :ativo_pge do
    get 'welcome/index'
  end

  devise_for :admins

  root to: 'ativo_pge/welcome#index'
end
