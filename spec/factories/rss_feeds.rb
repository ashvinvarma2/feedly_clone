# frozen_string_literal: true

FactoryBot.define do
  factory :rss_feed do
    title { "Sample Feed" }
    link { "https://www.thehindu.com/news/national/feeder/default.rss" }
    favicon_url { "https://www.thehindu.com/favicon.ico" }
  end
end
