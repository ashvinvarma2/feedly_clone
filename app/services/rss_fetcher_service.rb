# app/services/rss_fetcher_service.rb

class RssFetcherService
  def initialize(rss_feed_url)
    @rss_feed_url = rss_feed_url
  end

  def fetch_rss_feeds
    xml_content = HTTParty.get(@rss_feed_url).body
    doc = Nokogiri::XML(xml_content)

    debugger
    namespaces = { 'media' => 'http://search.yahoo.com/mrss/' }

    items = doc.xpath('//item')
    results = []

    items.each do |item|
      title = item.at_xpath('./title').text
      description = item.at_xpath('./description').text
      pub_date = item.at_xpath('./pubDate').text
      website_url = doc.at_xpath('//channel/link').text
      article_link = item.at_xpath('./link').text

      media_content_element = item.at_xpath('./media:content', namespaces)
      media_url = media_content_element ? media_content_element['url'] : ""

      results << {
        title: title,
        description: description,
        pub_date: pub_date,
        image_url: media_url,
        website_url: website_url,
        article_link: article_link
      }
    end

    return results
  end

  def fetch_rss_details
    xml_content = HTTParty.get(@rss_feed_url).body
    doc = Nokogiri::XML(xml_content)

    result = []
    result << {
      title: doc.at_xpath('//channel/image/title').text,
      logo_url: doc.at_xpath('//channel/image/url').text,

      favicon_element: doc.at_xpath('//link[@rel="shortcut icon"]')

    }

    return result
  end
end
