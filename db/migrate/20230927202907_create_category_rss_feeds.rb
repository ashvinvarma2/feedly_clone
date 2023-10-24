class CreateCategoryRssFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :category_rss_feeds do |t|
      t.references :category, null: false, foreign_key: true
      t.references :rss_feed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
