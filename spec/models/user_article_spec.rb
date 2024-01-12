# spec/models/user_article_spec.rb

require "rails_helper"

RSpec.describe UserArticle, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:article) }
  end
end
