class RssFeedsController < ApplicationController
  before_action :fetch_rss_feed, only: %i[show]

  def index; end

  def new
    render turbo_stream: turbo_stream.update(
      "dashboard_index",
      partial: "rss_feeds/new_feed"
    )
  end

  def add_to_category
    @category = Category.find(params[:category_id])
    @rss_feed = @category.rss_feeds.new(link: params[:rss_link])
    rss_fetcher = RssFetcherService.new(@rss_feed.link)
    @result = rss_fetcher.fetch_rss_feeds
    @rss_feed.title = @result.first[:title]
    if @rss_feed.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render json: { errors: @rss_feed.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def search
    result = RssFetcherService.new(params[:link]).fetch_rss_details

    render turbo_stream: turbo_stream.update(
      "rss_feed_results",
      partial: "rss_feeds/search_feed_result",
      locals: { result: result }
    )
  end

  def show
    rss_fetcher = RssFetcherService.new(@rss_feed.link)
    result = rss_fetcher.fetch_rss_feeds
    render turbo_stream: turbo_stream.update(
      "dashboard_index",
      partial: "rss_feeds/feeds",
      locals: { category: @rss_feed.category, result: result }
    )
  end

  private

  def rss_feed_params
    params.require(:rss_feed).permit(:link)
  end

  def fetch_rss_feed
    @rss_feed = RssFeed.find(params[:id])
  end
end
