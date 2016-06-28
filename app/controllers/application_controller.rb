class ApplicationController < ActionController::Base	
  protect_from_forgery with: :null_session
  include Authenticable
  before_action :only_json_request
  
end
