class RssFeedManagementService

  def initialize(link, category)
    @link = link
    @category = category
  end

  def process_rss_feed
    rss_feed = RssFeed.find_by(link: @link)

    if rss_feed
      assign_to_category(rss_feed)
    else
      create_new_rss_feed
    end
  end

  private

  def assign_to_category(rss_feed)
    @category.rss_feeds << rss_feed
  end

  def create_new_rss_feed
    rss_fetcher = RssFetcherService.new(@link)
    rss_feed_data = rss_fetcher.fetch_rss_details

    @rss_feed = @category.rss_feeds.create(
      link: @link,
      title: rss_feed_data[:title],
      favicon_url: rss_feed_data[:favicon_url]
    )

    ArticleMigrationService.new(@rss_feed).migrate_articles
  end
end
