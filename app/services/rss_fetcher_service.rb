# app/services/rss_fetcher_service.rb

class RssFetcherService
  def initialize(rss_feed_url)
    @rss_feed_url = rss_feed_url
  end

  def fetch_rss_feeds
    xml_content = HTTParty.get(@rss_feed_url).body
    doc = Nokogiri::XML(xml_content)

    page_title = doc.at_xpath("//channel/title").text
    website_url = doc.at_xpath("//channel/link").text
    favicon_url = fetch_favicon(website_url)
    items = doc.xpath("//item")
    results = []

    items.each do |item|
      title = item.at_xpath('./title').text
      description = item.at_xpath('./description').text
      pub_date = item.at_xpath('./pubDate').text

      article_link = item.at_xpath('./link').text

      media_element = find_media_element(item)
      media_url = media_element ? media_element["url"] : "/og-image.png"

      results << {
        title: title,
        description: description,
        pub_date: pub_date,
        image_url: media_url,
        link: article_link,
      }
    end

    return results
  end

  def fetch_rss_details
    xml_content = HTTParty.get(@rss_feed_url).body
    doc = Nokogiri::XML(xml_content)
    website_url = doc.at_xpath("//channel/link").text

    feed_details  = {}

    feed_details[:title] = doc.at_xpath("//channel/title").text
    feed_details[:rss_link] = @rss_feed_url
    feed_details[:favicon_url] = fetch_favicon(website_url)

    return feed_details
  end

  def find_media_element(item)
    # List of possible media elements to check
    media_elements = [
      item.at_xpath("./media:content", "media" => "http://search.yahoo.com/mrss/"),
      item.at_xpath("./media:thumbnail", "media" => "http://search.yahoo.com/mrss/")
      # Add more media elements as needed
    ]
    # Return the first non-nil media element found
    media_elements.compact.first
  end

  def fetch_favicon(website_url)
    begin
      html_content = URI.open(website_url)
      page = Nokogiri::HTML(html_content)
      favicon_element = page.at('link[rel="icon"]') || page.at('link[rel="shortcut icon"]')
      favicon_url = favicon_element['href'] if favicon_element
      return favicon_url
    rescue StandardError => e
      puts "Error fetching favicon: #{e.message}"
      return nil
    end
  end
end
