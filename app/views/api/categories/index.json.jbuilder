json.partial! 'api/shared/common', common: @categories

json.set! :data do
  json.array! @categories[:data], :id, :name, :rate
end
