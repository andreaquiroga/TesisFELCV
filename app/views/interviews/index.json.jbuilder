json.array!(@interviews) do |interview|
  json.extract! interview, :id
  json.url interview_url(interview, format: :json)
end
