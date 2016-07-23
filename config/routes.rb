Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root                   									'static_pages#home'

  get    'manifesto' 									=>  'static_pages#manifesto' 

  get    'shop'      									=>  'shops#index'

  get    'tipjar'    									=>  'tip_jars#index'

  get    'forum'     									=>  'forums#index'

  get    'contact'   									=>  'contacts#new'

  get    'contacts'  									=>  'contacts#new'

  post   'contacts'  									=>  'contacts#create'

  get    'signup'  			  						=>  'users#new'

  post   'signup'   		  						=>  'users#create'

  get    'login'     									=>  'sessions#new'

  post   'login'     									=>  'sessions#create'
  
  delete 'logout'    									=>  'sessions#destroy'

  get    'users/:id' 									=>  'users#show', as: :user

  patch  'users/:id'                  =>  'users#ban'

  get    'users/:id/edit'             =>  'users#edit', as: :edit_user

  patch  'users/:id/edit'             =>  'users#update'

  get    '/users'                     =>  'users#index', as: :users

  get    'thankyou'  		  						=>  'static_pages#thanks'

  get    'cancel'   		  						=>  'static_pages#cancel'

  get    'forum/:id/move'             =>  'posts#move', as: :move

  patch  'forum/:id/move'             =>  'posts#move_update'

  get    'forum/:subject' 						=>  'forums#show', as: :subject

  get    'forum/:subject/new' 				=>  'posts#new', as: :new_post

  post   'forum/:subject/new' 				=>  'posts#create'

  get    'forum/:id/edit' 						=>  'posts#edit', as: :edit_post

  get    'forum/:subject/:id' 				=>  'posts#show', as: :post

  patch  'forum/:id/edit' 						=>  'posts#update'

  delete 'forum/:subject/:id'         =>  'posts#destroy'

  get    'forum/:subject/:id/comment' =>  'comments#new', as: :new_comment

  post   'forum/:subject/:id/comment' =>  'comments#create'

  get    'forum/:subject/:id/comment/edit' =>  'comments#edit', as: :edit_comment

  patch  'forum/:subject/:id/comment/edit' =>  'comments#update'

  delete 'forum/:subject/:id/comment' =>  'comments#destroy', as: :delete_comment

  patch  'forum/:id/:sticky/sticky' 	=>  'posts#sticky', as: :sticky_comment

  patch  'forum/:id/:closed/close'    =>  'posts#close', as: :close_comment

  resources :account_activations, only: [:edit]


end
