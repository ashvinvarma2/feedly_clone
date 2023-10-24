class RssFeed < ApplicationRecord
  has_many :articles
  has_many :category_rss_feeds, dependent: :destroy
  has_many :categories, through: :category_rss_feeds
  has_many :favorites, as: :favoritable
end
