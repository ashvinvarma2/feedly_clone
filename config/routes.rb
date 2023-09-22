Rails.application.routes.draw do
  devise_for :users

  resources :categories
  get "rss_feeds/search", to: "rss_feeds#search", as: :search_rss_feeds
  get "rss_feeds/add_to_category", to: "rss_feeds#add_to_category", as: :add_to_category_rss_feeds
  resources :rss_feeds

  resources :dashboard, only: :index
  root to: "dashboard#index"
end
