Rails.application.routes.draw do
  namespace :ativo_pge do
    resources :admins
    resources :ativos
  end

  namespace :ativo_pge do
    get 'welcome/index'
  end
  
  devise_for :admins

  root to: 'ativo_pge/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
