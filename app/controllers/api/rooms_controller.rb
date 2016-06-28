class Api::RoomsController < ApplicationController
  before_action :validate_params, only: [:search]

  def search
  	status = Booking.validate_booking_range params[:check_in_at], params[:check_out_at]
  	if status.nil?
  		rooms = Room.search_rooms params
      @rooms = { success: true, message: '', code: 200, data: rooms }
  	else
      @rooms = { success: false, message: status, code: 422, data: [] }
  	end
  end


  private
  
  def validate_params  # validate format of date
  	params[:check_in_at] = validate_date params[:check_in_at]
  	params[:check_out_at] = validate_date params[:check_out_at]
  end

  def validate_date dt  # return date if valid else false
  	begin
       	Date.parse(dt.to_s)
    rescue ArgumentError
       	return false
    end
  end
  	
end
