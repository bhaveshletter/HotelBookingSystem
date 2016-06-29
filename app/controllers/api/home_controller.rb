class Api::HomeController < Api::ApplicationController

  def welcome
  	@welcome = { success: true, message: "Welcome to Hotel Booking System", code: 200 }
  end

end
