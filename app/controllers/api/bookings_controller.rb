class Api::BookingsController < Api::ApplicationController
  before_action :authenticate_with_token!

  def index
	bookings = admin? ? Booking.all : current_user.bookings.includes(:room)
	@bookings = { success: true, message: '', code: 200, data: bookings }
  end

  def create
    unless admin?  #  admin user not allow to book
	  booking = current_user.bookings.build booking_params
	  if booking.save
	  	#TODO: send notification through model
	  	@booking = { success: true, message: '', code: 200, data: [booking] }
	  else
	  	@booking = { success: false, message: booking.errors, code: 422, data: [] }
	  end
	else
	  @booking = { success: false, message: "Admin can't book", code: 403, data: [] }
	end
  end

  def update
    booking = admin? ? Booking.find_by(id: params[:id]) : current_user.bookings.find_by(id: params[:id])

	if booking && booking.update(status_only)
	  #TODO: send notification through model
	  @booking = { success: true, message: '', code: 200, data: [booking] }
	else
	  errors = booking.errors if booking && booking.errors
	  @booking = { success: false, message: errors || "Not found", code: 422, data: [] }
	end
  end


  private
  
  def booking_params
	params.require(:booking).permit(:check_in_at, :check_out_at, :room_id)
  end

  def status_only
	params.require(:booking).permit(:status)
  end

end
