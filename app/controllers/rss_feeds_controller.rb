class RssFeedsController < ApplicationController
  before_action :set_rss_feed, only: %i[show mark_read_unread]

  def index; end

  def new
    render turbo_stream: turbo_stream.update(
      "dashboard_index",
      partial: "rss_feeds/new_feed"
    )
  end

  def add_to_category
    @category = Category.find(params[:category_id])
    RssFeedManagementService.new(params[:rss_link], @category).process_rss_feed
    flash[:toastr] = { "success" => "Rss Feed Added Successfully!" }
    respond_to do |format|
      format.turbo_stream
    end
  end

  def search
    begin
      result = RssFetcherService.new(params[:link]).fetch_rss_details
      render turbo_stream: turbo_stream.update(
        "rss_feed_results",
        partial: "rss_feeds/search_feed_result",
        locals: { result: result }
      )
    rescue StandardError => e
      @error_message = "Please enter a valid Rss Link"
      render turbo_stream: turbo_stream.update(
        "dashboard_index",
        partial: "rss_feeds/new_feed"
      )
    end
  end

  def show
    board_ids = current_user.board_ids.any? ? current_user.board_ids : [0]
    @result = @rss_feed.articles
                       .select("articles.*,
                               bool_or(user_articles.marked_as_read) as marked_as_read,
                               bool_or(user_articles.read_later) as read_later,
                               bool_or(user_articles.marked_as_read_and_hide) as marked_as_read_and_hide,
                               array_agg(board_articles.board_id) as b_ids")
                       .joins("LEFT JOIN board_articles ON articles.id = board_articles.article_id AND board_articles.board_id IN (#{board_ids.join(',')})")
                       .joins("LEFT JOIN user_articles ON articles.id = user_articles.article_id AND user_articles.user_id = #{current_user.id}")
                       .group("articles.id")
  end

  def mark_read_unread
    article = Article.find(params[:article_id])
    user_article = UserArticle.find_or_initialize_by(user: current_user, article: article)
    if params[:hide] == "true"
      user_article.marked_as_read = true
      user_article.marked_as_read_and_hide =  true
    else
      user_article.marked_as_read = !user_article.marked_as_read
      user_article.marked_as_read_and_hide = false unless user_article.marked_as_read
    end

    if user_article.save
      if user_article.saved_change_to_marked_as_read?(from: true, to: false) && !user_article.read_later
        user_article.destroy
      end
    end

    render turbo_stream: []
  end

  def save_read_later
    article = Article.find(params[:article_id])
    user_article = UserArticle.find_or_initialize_by(user: current_user, article: article)
    user_article.read_later = !user_article.read_later
    flash_message = user_article.read_later ? "Saved to Read Later" : "Removed from Read Later"
    flash[:toastr] = { "success" => flash_message }
    if user_article.save
      if user_article.saved_change_to_read_later?(from: true, to: false) && !user_article.marked_as_read
        user_article.destroy
      end
    end

    render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
  end

  def recently_read_feeds
    board_ids = current_user.board_ids.any? ? current_user.board_ids : [0]
    @result = Article.select("articles.*,
                             bool_or(user_articles.marked_as_read) as marked_as_read,
                             bool_or(user_articles.read_later) as read_later,
                             array_agg(board_articles.board_id) as b_ids")
                     .joins("LEFT JOIN board_articles ON articles.id = board_articles.article_id AND board_articles.board_id IN (#{board_ids.join(',')})")
                     .joins("LEFT JOIN user_articles ON articles.id = user_articles.article_id AND user_articles.user_id = #{current_user.id}")
                     .where("user_articles.marked_as_read = true")
                     .group("articles.id")

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show_read_later
    board_ids = current_user.board_ids.any? ? current_user.board_ids : [0]
    @result = Article.select("articles.*,
                             bool_or(user_articles.marked_as_read) as marked_as_read,
                             bool_or(user_articles.read_later) as read_later,
                             array_agg(board_articles.board_id) as b_ids")
                     .joins("LEFT JOIN board_articles ON articles.id = board_articles.article_id AND board_articles.board_id IN (#{board_ids.join(',')})")
                     .joins("LEFT JOIN user_articles ON articles.id = user_articles.article_id AND user_articles.user_id = #{current_user.id}")
                     .where("user_articles.read_later = true")
                     .group("articles.id")

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show_article
    article = Article.find(params[:id])
    @article = article.setup_article_for_feed(current_user)
    respond_to do |format|
      format.js { render content_type: "text/javascript" }
    end
  end

  def unfollow
    @rss_feed = RssFeed.find(params[:id])
    current_user.category_rss_feeds.where(rss_feed_id: @rss_feed.id).destroy_all
    current_user.favorites.where(favoritable_id: @rss_feed.id, favoritable_type: "RssFeed").destroy_all
    flash[:toastr] = { "success" => "Rss Feed Unfollowed!!" }
    turbo_stream
  end

  private

  def rss_feed_params
    params.require(:rss_feed).permit(:link, :marked_as_read, :read_later)
  end

  def set_rss_feed
    @rss_feed = RssFeed.find(params[:id])
  end
end
