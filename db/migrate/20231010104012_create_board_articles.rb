class CreateBoardArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :board_articles do |t|
      t.references :board, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
