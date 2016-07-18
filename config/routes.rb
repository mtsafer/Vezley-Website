Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root                   'static_pages#home'

  get    'manifesto' =>  'static_pages#manifesto' 

  get    'shop'      =>  'shops#index'

  get    'tipjar'    =>  'tip_jars#index'

  get    'forum'     =>  'forums#index'

  get    'contact'   =>  'contacts#new'

  get    'contacts'  =>  'contacts#new'

  post   'contacts'  =>  'contacts#create'

  get    'signup'    =>  'users#new'

  post   'signup'    =>  'users#create'

  get    'login'     =>  'sessions#new'

  post   'login'     =>  'sessions#create'
  
  delete 'logout'    =>  'sessions#destroy'

  get    'users/:id' =>  'users#show'

  get    'thankyou'  =>  'static_pages#thanks'

  get    'cancel'    =>  'static_pages#cancel'


end
