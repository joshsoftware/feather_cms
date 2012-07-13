FeatherCms::Engine.routes.draw do

  #match 'page/:type/(:status)' => 'page#page', :as => :feather_page
  #get 'pages' => 'feathers#index', :as => :feather_pages

  get 'preview/:id' => 'pages#preview', :as => 'page_preview'

  resources :pages

end
