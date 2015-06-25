Rails.application.routes.draw do
	root 'static_pages#home'

  get 'users/:user_name' => 'users#show'
	get 'watch_lists/new' => 'watch_lists#new'
	post 'watch_lists' => 'watch_lists#create'
	get 'watch_lists/:season' => 'watch_lists#show'

	get 'home/:season' => 'static_pages#home'

	get 'auth/:provider/callback' => 'sessions#create'

	post "logout" => "sessions#destroy"

	namespace :admin do
		root "seasons#index"
		post 'programs/csv' => 'programs#create_with_csv'
		resources :seasons, :only => [:index, :destroy] do
			resources :programs, :only => [:index, :edit, :destroy, :create, :update], shallow: true
		end
		resources :details, :only => [:destroy, :update]
	end
end
