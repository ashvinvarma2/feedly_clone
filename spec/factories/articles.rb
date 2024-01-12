# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Article #{n}" }
    description { "Lorem ipsum dolor sit amet, consectetur adipiscing elit." }
    pub_date { Time.now }
    image_url { "https://example.com/image.jpg" }
    link { "https://example.com/article/#{SecureRandom.uuid}" }
    association :rss_feed, factory: :rss_feed
  end
end
