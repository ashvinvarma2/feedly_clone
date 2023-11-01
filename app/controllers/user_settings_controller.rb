class UserSettingsController < ApplicationController
  def index
    render turbo_stream: turbo_stream.update(
      "dashboard_index",
      partial: "user_settings/settings"
    )
  end

  def update
    @user_setting = UserSetting.find(params[:id])
    @user_setting.update(option_id: params[:option_id])
    flash[:toastr] = { "success" => "Settings Updated!" }

    turbo_stream
  end
end
