ClassStatus::Application.routes.draw do
  devise_for :users

	unauthenticated :user do
		root to: "static#index"
	end

	authenticated :user do
		root to: "users#dashboard", as: :dashboard
	end

	get    'users/plans',   to: 'users#plans_edit',      as: 'plans'
	patch  'users/plans',   to: 'users#plans_update',      as: 'plans_update'
	get    'users/billing', to: 'users#billing_edit',   as: 'billing_edit'
	patch  'users/billing', to: 'users#billing_update', as: 'billing_update'
	get "about", to: "static#about", :as => 'about'
	get "privacy", to: "static#privacy", :as => 'privacy'

	resources :class_sessions do
		get  'cancel', on: :member
		post 'cancel', on: :member
		post 'subscribe', on: :member
		delete 'subscribe', on: :member, to: 'class_sessions#unsubscribe', as: 'unsubscribe'
	end
end
