class Category < ApplicationRecord
  belongs_to :user
  has_many :category_rss_feeds, dependent: :destroy
  has_many :rss_feeds, through: :category_rss_feeds
  has_many :favorites, as: :favoritable, dependent: :destroy
end
