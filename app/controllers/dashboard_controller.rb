class DashboardController < ApplicationController
  before_action :set_dashboard, only: %w[index all_feeds]

  def index
    @category = Category.new
    board_ids = current_user.board_ids.any? ? current_user.board_ids : [0]
    user_rss_feed_ids = current_user.category_rss_feeds.pluck(:rss_feed_id)

    @result = Article.select("articles.*,
                               bool_or(user_articles.marked_as_read) as marked_as_read,
                               bool_or(user_articles.read_later) as read_later,
                               bool_or(user_articles.marked_as_read_and_hide) as marked_as_read_and_hide,
                               array_agg(board_articles.board_id) as b_ids")
                     .joins("LEFT JOIN board_articles ON articles.id = board_articles.article_id AND board_articles.board_id IN (#{board_ids.join(',')})")
                     .joins("LEFT JOIN user_articles ON articles.id = user_articles.article_id AND user_articles.user_id = #{current_user.id}")
                     .where("DATE(articles.pub_date) = ?", Date.today)
                     .where(articles: { rss_feed_id: user_rss_feed_ids })
                     .group("articles.id")

    respond_to do |format|
      format.turbo_stream do
        render_feeds("Today's Feeds", @result)
      end
      format.html
    end
  end

  def all_feeds
    board_ids = current_user.board_ids.any? ? current_user.board_ids : [0]
    user_rss_feed_ids = current_user.category_rss_feeds.pluck(:rss_feed_id)
    @result = Article.select("articles.*,
                               bool_or(user_articles.marked_as_read) as marked_as_read,
                               bool_or(user_articles.read_later) as read_later,
                               bool_or(user_articles.marked_as_read_and_hide) as marked_as_read_and_hide,
                               array_agg(board_articles.board_id) as b_ids")
                     .joins("LEFT JOIN board_articles ON articles.id = board_articles.article_id AND board_articles.board_id IN (#{board_ids.join(',')})")
                     .joins("LEFT JOIN user_articles ON articles.id = user_articles.article_id AND user_articles.user_id = #{current_user.id}")
                     .where(articles: { rss_feed_id: user_rss_feed_ids })
                     .group("articles.id")

    respond_to do |format|
      format.html
    end
  end
end
