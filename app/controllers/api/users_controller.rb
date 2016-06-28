class Api::UsersController < ApplicationController
#  respond_to :json

  def index
    users = User.all
    @users = { success: true, message: '', code: 200, data: users }
    #render json: { success: true, message: '', code: 200, data: users }, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user = { success: true, message: '', code: 200, data: [@user] }
      #render json: { success: true, message: '', code: 200, data: [@user] }, status: :ok
    else
      @user = { success: false, message: @user.errors, code: 422, data: [] }
      #render json: { success: false, message: @user.errors, code: 422, data: [] }, status: :unprocessable_entity
    end
  end


  private
  
  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
