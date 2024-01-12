# spec/models/user_setting_spec.rb

require "rails_helper"

RSpec.describe UserSetting, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:setting) }
    it { is_expected.to belong_to(:option) }
  end
end
