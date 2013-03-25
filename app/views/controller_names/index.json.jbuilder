json.array!(@controller_names) do |controller_name|
  json.extract! controller_name, :name
  json.url controller_name_url(controller_name, format: :json)
end