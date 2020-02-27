Rails.application.routes.draw do  
  mount Ckeditor::Engine => '/ckeditor'  
  root to: "homes#index"
 
  devise_for :admin,
  :path_names => {
    :sign_in => 'sign_in',
    :sign_out => 'sign_out',
    :password => 'password',
    :confirmation => 'verification',
    :unlock => 'unblock',
    :sign_up => 'sign_up'
     }, controllers: { sessions: 'admin/sessions', :registrations => 'admin/registrations', :passwords => 'admin/passwords' }
   

	 namespace :admin do 
      root to: "homes#index"
      resources :organizations, except: :show
      resources :cms_pages, except: :show
      get '/change_password' => 'admins#change_password'
      patch '/change_password' => 'admins#change_password'     
      get '/check_uniqueness' => 'admins#check_uniqueness', :as => :check_uniqueness
      post '/delete_record', to: 'admin_parents#delete_record', as: 'delete_record'
      post '/perform_bulk_action', to: 'admin_parents#perform_bulk_action', as: 'perform_bulk_action'  
      post '/save_university' => 'organizations#save_university', :as => :save_university
	 end


  match '/cms/:seo_url' => 'cmspages#index', :via => :get , :as => :cms_page
  get 'error' => 'application#common_error', :as => :common_error
  #get '*path', :to => 'application#not_found'

end
