json.set! :data do
  json.array! bookings do |booking|
    json.id booking.id
    json.booked_at booking.created_at
    json.status booking.status
    json.comment booking.comment
    json.check_in_at booking.check_in_at
    json.check_out_at booking.check_out_at

    json.user do 
	  json.id booking.room.id
      json.name booking.room.name
      json.description booking.room.description
      json.category booking.room.category, :id, :name, :rate, :description
    end
  end
end