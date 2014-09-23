json.array!(@stations) do |station|
  json.extract! station, :id, :name, :phone
  json.url station_url(station, format: :json)
end
