class CreateRssFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :rss_feeds do |t|
      t.string :title
      t.string :link
      t.string :favicon_url
      t.timestamps
    end
  end
end
