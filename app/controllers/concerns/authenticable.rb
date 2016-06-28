module Authenticable
	
  def current_user
	  @current_user || request.headers["Authorization"] && User.find_by(auth_token: request.headers["Authorization"])
  end

  def authenticate_with_token!
    render json: { success: false, message: "Not authenticated", code: 401, data: [] }, status: :unauthorized unless current_user.present?
  end

  def only_json_request
    render json: { success: false, message: "Request headers' 'Content-Type' should 'application/json;' ", code: 400, data: [] }, status: :bad_request unless request.headers["Content-Type"] =~ /json/
  end

  def admin?
    current_user.email == User::ADMIN_EMAIL
  end

end