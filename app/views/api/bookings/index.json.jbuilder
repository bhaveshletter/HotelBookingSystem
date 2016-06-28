json.partial! 'api/shared/common', common: @bookings

json.partial! 'api/bookings/list', bookings: @bookings[:data]