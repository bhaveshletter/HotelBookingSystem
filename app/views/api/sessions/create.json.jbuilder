json.partial! 'api/shared/common', common: @user

json.set! :data do
  json.array! @user[:data], :id, :email, :contact_no, :auth_token
end