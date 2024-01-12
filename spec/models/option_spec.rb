# spec/models/option_spec.rb

require "rails_helper"

RSpec.describe Option, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:setting) }
  end
end
