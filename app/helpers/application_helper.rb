module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end

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

  def can_show_hide_button?
    valid_combinations = [
      ["categories", "show"],
      ["dashboard", "index"],
      ["rss_feeds", "show"]
    ]

    valid_combinations.include?([controller_name, action_name]) &&
      current_user.user_settings.joins(:setting)
                  .find_by(settings: { title: "Hide Read Articles Option" })
                  &.option&.title == "Show"
  end

  def list_themes
    "<ul data-controller='theme-switcher'>
      <li id='lightModeBtn'>
        <div class='list-item'>
          <span data-action='click->theme-switcher#switchTheme' data-view='light-theme'>
            <i class='fa-regular fa-circle'></i>
            Light
          </span>
        </div>
      </li>
      <li id='darkModeBtn'>
        <div class='list-item'>
          <span data-action='click->theme-switcher#switchTheme' data-view='dark-theme'>
            <i class='fa-regular fa-circle'></i>
            Dark
          </span>
        </div>
      </li>
    </ul>"
  end

  def default_view
    view = current_user.user_settings
                       .joins(:setting)
                       .where(settings: { title: "Default Presentation" }).first.option.title
    case view
    when "Titles-Only View"
      "title-view"
    when "Magazine View"
      "magazine-view"
    when "Cards View"
      "card-view"
    else
      "card-view"
    end
  end

  def show_sidebar?
    option = current_user.user_settings
                         .joins(:setting)
                         .where(settings: { title: "Show Slider" }).first.option
    return "active" if option.title == "Show"
  end
end
