Rails.application.routes.draw do
	root 'static_pages#home'
	get 'home/:season' => 'static_pages#home'

	get 'auth/:provider/callback' => 'sessions#create'
	post "logout" => "sessions#destroy"

  get 'users/:user_name' => 'users#show'

	resources :users, :param => :name, :only => [:show] do
		resources :watch_lists, shallow: true, :except => [:show]
	end



	namespace :admin do
		root "seasons#index"
		post 'programs/csv' => 'programs#create_with_csv'
		resources :seasons, :only => [:index, :update, :destroy] do
			resources :programs, :only => [:index, :edit, :destroy, :create, :update], shallow: true
		end
		resources :details, :only => [:destroy, :update]
	end
end
