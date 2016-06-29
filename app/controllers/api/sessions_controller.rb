class Api::SessionsController < Api::ApplicationController  

  def create
	user_password = params[:session][:password]
	user_email = params[:session][:email]
	user = user_email.present? && User.find_by(email: user_email)

	if user.valid_password? user_password
	  sign_in user, store: false
	  user.generate_auth_token!
	  user.save
	  @user = { success: true, message: "Send auth_token with headers 'Authorization'", code: 200, data: [user] }
	else
	  @user = { success: false, message: "Invalid email or password", code: 422, data: [] }
	end
  end

end
