class RssFeedsController < ApplicationController
  before_action :fetch_rss_feed, only: %i[create show]

  def index; end

  def new
    render turbo_stream: turbo_stream.update(
      "dashboard_index",
      partial: "rss_feeds/new_feed"
    )
  end

  def create
    @rss_feed = RssFeed.new(rss_feed_params)

    if @rss_feed.save
      respond_to do |format|
        format.turbo_stream
        format.html { render json: { rss_feed: @rss_feed }, status: :created }
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
    debugger
  end

  private

  def rss_feed_params
    params.require(:rss_feed).permit(:link)
  end

  def fetch_rss_feed
    @rss_feed = RssFeed.find(params[:id])
  end
end
