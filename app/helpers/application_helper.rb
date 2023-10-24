module ApplicationHelper
  def time_ago(timestamp)
    current_time = Time.now
    difference = (current_time - timestamp).to_i

    if difference < 3600
      "#{(difference / 60).to_i} min ago"
    elsif difference < 90000 # 25 hours in seconds
      "#{(difference / 3600).to_i} hours ago"
    else
      "#{(difference / 86400).to_i} days ago"
    end
  end

  def can_show_favorite_button?
    if controller_name == "boards" && action_name == "show"
      @favoritable = current_user.boards.find_by(id: params[:id])
      true
    elsif controller_name == "rss_feeds" && action_name == "show"
      @favoritable = RssFeed.find_by(id: params[:id])
      true
    elsif controller_name == "categories" && action_name == "show"
      @favoritable = current_user.categories.find_by(id: params[:id])
      true
    else
      false
    end
  end
end
