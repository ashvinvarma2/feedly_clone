class RssFeed < ApplicationRecord
  has_many :articles
  has_many :category_rss_feeds, dependent: :destroy
  has_many :categories, through: :category_rss_feeds
  has_many :favorites, as: :favoritable, dependent: :destroy

  def self.migrate_all_feeds
    all.each do |feed|
      ArticleMigrationService.new(feed).delay.migrate_articles
    end
  end
end
