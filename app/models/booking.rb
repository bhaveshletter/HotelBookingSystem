class Booking < ApplicationRecord
  #  Constatns
  STATUS = %w(booked checkedin checkedout cancelled)

  belongs_to :user
  belongs_to :room

  # validations
  validates :status,
    inclusion: { in: STATUS,
    message: "%{value} is not a valid status" }
  validates :check_in_at, presence: true
  validates :check_out_at, presence: true
  validate :check_in_out_date_validation, on: :create
  validate :booking_available, on: :create
  
  # Callback
  after_update :move_to_archive

  # Methods
  protected  
  def check_in_out_date_validation
    p '++++++++++++++++++++++++++++++++++++++'
    status = Booking.validate_booking_range check_in_at, check_out_at
    unless status.nil?
      errors.add(:base, status)
    end
  end

  # check check in and check out date is in range of up to 6 months, greater than each other, etc
  def self.validate_booking_range check_in_at, check_out_at
    if check_in_at && check_out_at
      if check_in_at > check_out_at
        "Check in date can't be greater than check out date"
      elsif check_out_at > (Date.today + 6.months)
        "Booking allow only up to 6 months in advance"
      elsif check_in_at < Date.today || check_out_at < Date.today
        "Booking date is of past"
      end
    else
      "Check in and check out date should be valid and present"
    end
  end
  
  def booking_available  # TODO: fix with lock
    status = Room.booking_exist? check_in_at, check_out_at, room_id
    unless status.empty?
      errors.add(:base, "Sorry, Same room is already booked for same duration")
    end
  end

  # Allow booking & fast search, move book record to archieve table & delete from existing table if updated with status of 'checkedout', 'cancelled'
  def move_to_archive
    if [STATUS[2], STATUS[3]].include? self.status
      BookingArchive.create! check_in_at: self.check_in_at, check_out_at: self.check_out_at, status: self.status, comment: self.comment
      self.destroy
    end
  end

end