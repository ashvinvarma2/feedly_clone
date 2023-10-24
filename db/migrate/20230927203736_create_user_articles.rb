class CreateUserArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_articles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.boolean :marked_as_read, default: false
      t.boolean :read_later, default: false
      t.timestamps
    end
  end
end
