class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def render_feeds(title, result)
    render turbo_stream: turbo_stream.update(
      "dashboard_index",
      partial: "rss_feeds/feeds",
      locals: { title: title, result: result }
    )
  end
end
