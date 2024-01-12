class UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:toastr] = { "success" => "Profile updated!" }
    turbo_stream
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

end
