class AddMarkAsReadAndHideToUserArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :user_articles, :marked_as_read_and_hide, :boolean, default: false
  end
end
