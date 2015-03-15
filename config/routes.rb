Rails.application.routes.draw do
  # get 'pictures' => 'pictures#index'
  get 'pictures/:id' => 'pictures#show', as: 'picture'

  # get 'jokes' => 'jokes#index'
  get 'jokes/:id' => 'jokes#show', as: 'joke'

  # get 'articles' => 'articles#index'
  get 'articles/:id' => 'articles#show', as: 'article'

  # get 'videos' => 'videos#index'
  get 'videos/:id' => 'videos#show', as: 'video'

  get 'comics/:id' => 'comics#show', as: 'comic'

  get 'about' => 'welcome#about'

  # archive
  get 'archive/:date' => 'welcome#archive', as: 'front_page_archive'
  # get 'archive/articles/:date' => 'articles#archive', as: 'articles_archive'
  # get 'archive/jokes/:date' => 'jokes#archive', as: 'jokes_archive'
  # get 'archive/pictures/:date' => 'pictures#archive', as: 'pictures_archive'
  # get 'archive/videos/:date' => 'videos#archive', as: 'videos_archive'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#home'

  get 'sitemap' => 'welcome#sitemap'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
