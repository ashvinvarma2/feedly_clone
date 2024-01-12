# spec/models/category_spec.rb

require "rails_helper"

RSpec.describe Category, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:category_rss_feeds).dependent(:destroy) }
    it { is_expected.to have_many(:rss_feeds).through(:category_rss_feeds) }
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
  end
end
