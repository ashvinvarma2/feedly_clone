class CreateRssFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :rss_feeds do |t|
      t.string :title
      t.string :logo
      t.string :link

      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
