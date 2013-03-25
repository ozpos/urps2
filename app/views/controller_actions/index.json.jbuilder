json.array!(@controller_actions) do |controller_action|
  json.extract! controller_action, :name, :action_name_id, :controller_name_id
  json.url controller_action_url(controller_action, format: :json)
end