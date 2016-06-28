json.partial! 'api/shared/common', common: @users

json.set! :data do
  json.array! @users[:data], :id, :email, :contact_no
end