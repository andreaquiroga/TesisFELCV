json.array!(@cases) do |case|
  json.extract! case, :id
  json.url case_url(case, format: :json)
end
