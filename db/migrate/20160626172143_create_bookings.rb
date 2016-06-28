class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.date :check_in_at
      t.date :check_out_at
      t.string :status, :default => "booked"
      t.text :comment
      t.references :user, foreign_key: true, index: true
      t.references :room, foreign_key: true, index: true

      t.timestamps
    end
  end
end
