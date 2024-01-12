# spec/models/setting_spec.rb

require "rails_helper"

RSpec.describe Setting, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:options).dependent(:destroy) }
    it { is_expected.to have_many(:user_settings).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:user_settings).dependent(:destroy) }
  end
end
