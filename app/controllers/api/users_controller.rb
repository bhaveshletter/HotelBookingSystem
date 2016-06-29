class Api::UsersController < Api::ApplicationController

  def index
    users = User.all
    @users = { success: true, message: '', code: 200, data: users }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user = { success: true, message: '', code: 200, data: [@user] }
    else
      @user = { success: false, message: @user.errors, code: 422, data: [] }
    end
  end


  private
  
  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
