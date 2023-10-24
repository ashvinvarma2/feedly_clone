class ArticleMigrationService
  def initialize(rss_feed)
    @rss_feed = rss_feed
    @links = @rss_feed.articles.pluck(:link)
  end

  def migrate_articles
    rss_fetcher = RssFetcherService.new(@rss_feed.link)
    rss_feed_data = rss_fetcher.fetch_rss_feeds

    rss_feed_data.each do |feed_item|
      break if article_exists?(feed_item[:link])

      Article.create(feed_item.merge(rss_feed_id: @rss_feed.id))
    end
  end

  def article_exists?(link)
    @links.include?(link)
  end
end
