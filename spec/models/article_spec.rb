# spec/models/article_spec.rb

require "rails_helper"

RSpec.describe Article, type: :model do
  let(:rss_feed) { create(:rss_feed) }
  let(:user) { create(:user) }
  let(:board) { create(:board, user: user) }
  let(:article) { create(:article, rss_feed: rss_feed) }

  describe "associations" do
    it { is_expected.to belong_to(:rss_feed) }
    it { is_expected.to have_many(:user_articles) }
    it { is_expected.to have_many(:users).through(:user_articles) }
    it { is_expected.to have_many(:board_articles) }
    it { is_expected.to have_many(:boards).through(:board_articles) }
  end

  describe "methods" do
    describe "#setup_article_for_feed" do
      it "sets up article attributes for a user" do
        user_article = create(:user_article, user: user, article: article)
        create(:board_article, board: board, article: article)

        result = article.setup_article_for_feed(user)

        expect(result["page_title"]).to eq(rss_feed.title)
        expect(result["marked_as_read"]).to eq(user_article.marked_as_read)
        expect(result["read_later"]).to eq(user_article.read_later)
        expect(result["b_ids"]).to eq([board.id])
      end

      it "handles the case where there is no user_article" do
        result = article.setup_article_for_feed(user)

        expect(result["page_title"]).to eq(rss_feed.title)
        expect(result["marked_as_read"]).to eq(false)
        expect(result["read_later"]).to eq(false)
        expect(result["b_ids"]).to eq([])
      end
    end
  end
end
