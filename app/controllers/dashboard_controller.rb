class DashboardController < ApplicationController

  def index
    @category = Category.new
    @categories = Category.all
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end
end
