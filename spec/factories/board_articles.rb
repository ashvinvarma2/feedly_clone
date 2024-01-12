# frozen_string_literal: true

FactoryBot.define do
  factory :board_article, class: "BoardArticle" do
    article { FactoryBot.create(:article) }
    board { FactoryBot.create(:board) }
  end
end
