class Article < ApplicationRecord
  belongs_to :rss_feed
  has_many :user_articles
  has_many :users, through: :user_articles
  has_many :board_articles
  has_many :boards, through: :board_articles

  def setup_article_for_feed(user)
    user_article = user_articles.find_by(user_id: user.id)
    marked_as_read = user_article&.marked_as_read || false
    read_later = user_article&.read_later || false
    article = attributes

    article["page_title"] = rss_feed.title
    article["marked_as_read"] = marked_as_read
    article["read_later"] = read_later
    article["b_ids"] = boards.where(user_id: user.id).ids
    article
  end
end
