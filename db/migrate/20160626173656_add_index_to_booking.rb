class AddIndexToBooking < ActiveRecord::Migration[5.0]
  def change
  	add_index :bookings, [:check_in_at, :check_out_at]
  end
end
