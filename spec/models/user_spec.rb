# spec/models/user_spec.rb

require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:categories) }
    it { is_expected.to have_many(:category_rss_feeds).through(:categories) }
    it { is_expected.to have_many(:user_articles) }
    it { is_expected.to have_many(:articles).through(:user_articles) }
    it { is_expected.to have_many(:favorites) }
    it { is_expected.to have_many(:boards) }
    it { is_expected.to have_many(:user_settings) }
    it { is_expected.to have_many(:settings).through(:user_settings) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe "callbacks" do
    describe "#setup_user_settings" do
      it "creates user settings after user creation" do
        user = create(:user)

        expect(user.user_settings.count).to eq(6)
        expect(user.settings.pluck(:id)).to contain_exactly(1, 2, 3, 4, 5, 6)
      end
    end
  end
end
