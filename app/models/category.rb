class Category < ApplicationRecord
  belongs_to :user
  has_many :rss_feeds
end
