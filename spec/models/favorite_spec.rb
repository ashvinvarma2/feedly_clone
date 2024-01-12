# spec/models/favorite_spec.rb

require "rails_helper"

RSpec.describe Favorite, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:favoritable) }
    it { is_expected.to belong_to(:user) }
  end
end
