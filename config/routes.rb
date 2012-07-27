FeatherCms::Engine.routes.draw do

  get 'preview/:id' => 'pages#preview', :as => 'page_preview'

  resources :pages

end
