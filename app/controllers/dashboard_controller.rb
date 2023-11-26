class DashboardController < ApplicationController
  before_action :set_dashboard, only: :index

  def index
    @category = Category.new

    sql_query =
      "SELECT
        articles.*,
        CASE WHEN user_articles.id IS NOT NULL THEN true ELSE false END AS marked_as_read,
        CASE WHEN user_articles.read_later = true THEN true ELSE false END AS read_later,
        CASE WHEN user_articles.marked_as_read_and_hide = true THEN true ELSE false END AS marked_as_read_and_hide
      FROM articles
      LEFT JOIN user_articles ON articles.id = user_articles.article_id AND user_articles.user_id = #{current_user.id}
      WHERE DATE(articles.pub_date) = CURRENT_DATE"

    # categories = Category.all
    # result = []

    # categories.each do |category|
    #   rss_feeds = category.rss_feeds.includes(:articles).limit(2)

    #   rss_feeds_data = rss_feeds.map do |rss_feed|
    #     {
    #       articles: rss_feed.articles.take(2)
    #     }
    #   end

    #   result << {
    #     category_name: category.name,
    #     rss_feeds: rss_feeds_data
    #   }
    # end

    @result = ActiveRecord::Base.connection.execute(sql_query).to_a
    respond_to do |format|
      format.turbo_stream do
        render_feeds("Today's Feeds", @result)
      end
      format.html
    end
  end

  private
end
