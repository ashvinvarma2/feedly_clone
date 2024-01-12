class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :clear_turbo_flash
  before_action :set_dashboard
  skip_before_action :verify_authenticity_token, if: :js_request?

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
    return if current_user.nil?

    @categories = current_user.categories
    @favorites = current_user.favorites
    @boards = current_user.boards
  end

  def js_request?
    request.format.js?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :password)
    end

    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :first_name, :last_name, :password, :password_confirmation, :current_password)
    end
  end
end
