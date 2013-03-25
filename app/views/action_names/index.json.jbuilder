json.array!(@action_names) do |action_name|
  json.extract! action_name, :name
  json.url action_name_url(action_name, format: :json)
end