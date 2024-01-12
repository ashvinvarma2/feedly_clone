Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  get "rss_feeds/search", to: "rss_feeds#search", as: :search_rss_feeds
  get "rss_feeds/add_to_category", to: "rss_feeds#add_to_category", as: :add_to_category_rss_feeds
  get "rss_feeds/mark_read_unread", to: "rss_feeds#mark_read_unread", as: :mark_read_unread_rss_feeds
  get "rss_feeds/recently_read_feeds", to: "rss_feeds#recently_read_feeds", as: :recently_read_feeds_rss_feeds
  get "rss_feeds/show_read_later", to: "rss_feeds#show_read_later", as: :show_read_later_rss_feeds
  get "rss_feeds/save_read_later", to: "rss_feeds#save_read_later", as: :save_read_later_rss_feeds
  get "rss_feeds/show_article/:id", to: "rss_feeds#show_article", as: :show_article_rss_feeds
  get "rss_feeds/unfollow/:id", to: "rss_feeds#unfollow", as: :unfollow_feed
  get "boards/save_feed_to_board", to: "boards#save_feed_to_board", as: :save_feed_to_board
  get "boards/remove_feed_from_board", to: "boards#remove_feed_from_board", as: :remove_feed_from_board
  get "dashboard/show_todays_feeds", to: "dashboard#show_todays_feeds", as: :show_todays_feeds
  get "favorites/handle_favorite", to: "favorites#handle_favorite", as: :handle_favorite
  get "dashboard/all_feeds", to: "dashboard#all_feeds", as: :all_feeds


  resources :categories
  resources :rss_feeds
  resources :dashboard, only: :index
  resources :boards
  resources :user_settings, only: %i[index update]
  resources :users, only: %i[edit update]

  root to: "dashboard#index"
end
