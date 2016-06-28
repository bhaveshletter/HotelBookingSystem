class Room < ApplicationRecord
  # [anti semi join] find rooms which are not booked during given date range
  scope :with_check_in_out_date, -> (check_in_at, check_out_at) { includes(:category).where.not("EXISTS (SELECT bookings.* FROM bookings where rooms.id = bookings.room_id AND bookings.check_in_at BETWEEN ? AND ? AND bookings.check_out_at BETWEEN ? AND ?)", check_in_at, check_out_at, check_in_at, check_out_at) }
  # [semi join] # booking creation not allow if same date range & room already booked
  scope :booking_exist?, -> (check_in_at, check_out_at, room_id) { where("EXISTS (SELECT bookings.* FROM bookings where rooms.id = bookings.room_id AND bookings.check_in_at BETWEEN ? AND ? AND bookings.check_out_at BETWEEN ? AND ? AND rooms.id = ?)", check_in_at, check_out_at, check_in_at, check_out_at, room_id) }

  belongs_to :category
  has_many :bookings
  has_many :users, through: :bookings

  has_many :booking_archives
  has_many :rooms, through: :booking_archives  

  protected  
  def self.search_rooms params
    rooms = Room.with_check_in_out_date params[:check_in_at], params[:check_out_at]
  	if params[:category_id]
  		rooms = rooms.where("rooms.category_id = ?", params[:category_id])
  	end    
    rooms
  end

end
