class Board < ApplicationRecord
  belongs_to :user
  has_many :board_articles
  has_many :articles, through: :board_articles
  has_many :favorites, as: :favoritable
end
