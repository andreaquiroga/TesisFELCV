json.array!(@direct_actions) do |direct_action|
  json.extract! direct_action, :id
  json.url direct_action_url(direct_action, format: :json)
end
