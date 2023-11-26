class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  after_action :clear_turbo_flash
  before_action :set_dashboard

  def render_feeds(title, result)
    render turbo_stream: turbo_stream.update(
      "dashboard_index",
      partial: "rss_feeds/feeds",
      locals: { title: title, result: result }
    )
  end

  def clear_turbo_flash
    if request.format.turbo_stream?
      flash[:toastr] = nil
    end
  end

  def set_dashboard
    @categories = current_user.categories
    @favorites = current_user.favorites
    @boards = current_user.boards
  end
end
