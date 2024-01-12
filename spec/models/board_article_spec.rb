# spec/models/board_article_spec.rb

require 'rails_helper'

RSpec.describe BoardArticle, type: :model do
  let(:board_article) { FactoryBot.create(:board_article, article: company, user: user) }

  describe "associations" do
    it { is_expected.to belong_to(:board) }
    it { is_expected.to belong_to(:article) }
  end
end
