json.partial! 'api/shared/common', common: @rooms

json.set! :data do
  json.array! @rooms[:data] do |room|
    json.id room.id
    json.name room.name
    json.category room.category, :id, :name, :rate, :description
  end
end