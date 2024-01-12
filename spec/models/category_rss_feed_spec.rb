# spec/models/category_rss_feed_spec.rb

require "rails_helper"

RSpec.describe CategoryRssFeed, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:rss_feed) }
  end
end
