# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

private

def create_rooms rooms, category
  rooms.each do |room|
	Room.create! name: room, category: category
  end
end

public

category_info = {delux: {title: 'Deluxe Rooms', rooms: ['A01', 'A02', 'A03', 'A04', 'A05', 'B01', 'B02', 'B03', 'B04', 'B05', 'C01', 'C02', 'C03', 'C04', 'C05', 'D01', 'D02', 'D03', 'D04', 'D05']},
				 luxury: {title: 'Luxury Rooms', rooms: ['A06', 'A07', 'A08', 'A09', 'A10', 'B06', 'B07', 'B08', 'B09', 'B10', 'C06', 'C07', 'C08', 'C09', 'C10', 'D06', 'D07', 'D08', 'D09', 'D10']},
				 luxury_suites: {title: 'Luxury', rooms: ['D11', 'D12', 'D13', 'D14', 'D15', 'D16', 'D17', 'D18', 'D19', 'D20', 'E01', 'E02']},
				 presidential_suites: {title: 'Presidential Suites', rooms: ['E03', 'E04', 'E05', 'E06', 'E07', 'E08', 'E09', 'E10']}}

users = [{email: User::ADMIN_EMAIL, contact_no: '1111111111', password: '123456', password_confirmation: '123456'},
		 {email: 'user1@example.com', contact_no: '1000000000', password: '654321', password_confirmation: '654321'}]

categories = [{name: category_info[:delux][:title], rate: 7000, description: 'Queen Size Bed'},
			  {name: category_info[:luxury][:title], rate: 8500, description: 'Queen Size Bed and Pool Facing'},
			  {name: category_info[:luxury_suites][:title], rate: 12000, description: 'King Size Bed and Pool Facing'},
			  {name: category_info[:presidential_suites][:title], rate: 20000, description: 'King Size Bed, Pool Facing with a Gym'}]

puts '++++++++++ Master data ++++++++++ creation start.'

puts '********* User ********* creation start.'
  User.create! users
puts '********* User ********* creation completed.'

puts '-------- Category respected room(s) ------ creation start.'
categories.each do |category|
  newCategory = Category.create! category
	if newCategory
	  case category[:name]
	  when category_info[:delux][:title]
	    create_rooms category_info[:delux][:rooms], newCategory
	  when category_info[:luxury][:title]
	    create_rooms category_info[:luxury][:rooms], newCategory
	  when category_info[:luxury_suites][:title]
		create_rooms category_info[:luxury_suites][:rooms], newCategory
	  when category_info[:presidential_suites][:title]
		create_rooms category_info[:presidential_suites][:rooms], newCategory
	  end
	end
end

puts '-------- Category respected room(s) ------ creation completed.'

puts '++++++++++ Master data ++++++++++ creation completed.'
