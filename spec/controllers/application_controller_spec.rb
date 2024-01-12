# spec/controllers/application_controller_spec.rb

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "#clear_turbo_flash" do
    before do
      sign_in(user)
    end

    it "clears Turbo Flash messages for Turbo Stream requests" do
      flash[:toastr] = Faker::String.random(length: 3..12)
      DashboardController.new.index
      expect(flash[:toastr]).to be_nil
    end
  end

  describe "#set_dashboard" do
    it "sets instance variables for categories, favorites, and boards" do
      get :index

      expect(assigns(:categories)).to eq(user.categories)
      expect(assigns(:favorites)).to eq(user.favorites)
      expect(assigns(:boards)).to eq(user.boards)
    end
  end

  describe "#js_request?" do
    it "returns true for JS requests" do
      request.env["HTTP_ACCEPT"] = "text/javascript"

      expect(controller.js_request?).to be_truthy
    end

    it "returns false for non-JS requests" do
      request.env["HTTP_ACCEPT"] = "text/html"

      expect(controller.js_request?).to be_falsey
    end
  end
end
