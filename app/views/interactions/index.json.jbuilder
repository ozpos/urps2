json.array!(@interactions) do |interaction|
  json.extract! interaction, :controller_action_id, :role_id
  json.url interaction_url(interaction, format: :json)
end