# spec/models/rss_feed_spec.rb

require "rails_helper"

RSpec.describe RssFeed, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:articles) }
    it { is_expected.to have_many(:category_rss_feeds).dependent(:destroy) }
    it { is_expected.to have_many(:categories).through(:category_rss_feeds) }
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
  end
end
