class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.datetime :pub_date
      t.string :image_url
      t.string :link
      t.references :rss_feed, null: false, foreign_key: true
      t.timestamps
    end
  end
end
