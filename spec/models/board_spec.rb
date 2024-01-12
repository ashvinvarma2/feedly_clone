# spec/models/board_spec.rb

require "rails_helper"

RSpec.describe Board, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:board_articles).dependent(:destroy) }
    it { is_expected.to have_many(:articles).through(:board_articles) }
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
  end
end
