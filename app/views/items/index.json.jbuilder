json.array!(@items) do |item|
  json.extract! item, :id, :name, :description, :place
  json.url item_url(item, format: :json)
end
