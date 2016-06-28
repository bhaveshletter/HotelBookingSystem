json.partial! 'api/shared/common', common: @booking

json.partial! 'api/bookings/list', bookings: @booking[:data]