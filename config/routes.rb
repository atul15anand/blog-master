Rails.application.routes.draw do
	root 'welcome#index'
	get 'welcome/about', to: 'welcome#about'
	get 'signup', to: 'users#new'
	resources  :articles
	resources :users, except: [:new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
