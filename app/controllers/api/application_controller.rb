class Api::ApplicationController < ActionController::Base	
  protect_from_forgery with: :null_session
  include Authenticable
  before_action :only_json_request

  #continue to use rescue_from in the same way as before
  #unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
  #end 

  #called by last route matching unmatched routes. Raises RoutingError which will be rescued from in the same way as other exceptions.
  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  #render 500 error 
  def render_error(e)
  	render json: { sucess: false, message: 'Server error', code: 500 }
  end
  
  #render 404 error
  def render_not_found(e)
	  render json: { success: false, message: 'Not found', code: 404 }
  end

  #render 400 error
  def render_bad_request(e)
    render json: { success: false, message: 'Bad request', code: 400 }
  end
  
end
