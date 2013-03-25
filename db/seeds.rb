# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

max_role = Role.find_by_name('Webmaster')
if max_role.nil?
  Role.create!([{:name => 'Webmaster'},
                {:name => 'Admin'},
                {:name => 'Moderator'},
                {:name => 'Editor'},
                {:name => 'Registered User'},
                {:name => 'Guest'}])
  max_role = Role.find_by_name('Webmaster')
end

# Define all resources
Rails.application.reload_routes!
all_routes = Rails.application.routes.routes

# Populate a table of controller and action names and controller_actions.
# Create Webmaster default role for each secure_resource.
all_routes.routes.each do |route|
  w = ActionDispatch::Routing::RouteWrapper.new(route)
  if w.endpoint == w.controller + "#" + w.action and !w.internal?
    c = ControllerName.find_or_create_by_name(w.controller)
    a = ActionName.find_or_create_by_name(w.action)
    res = ControllerAction.find_or_create_by_name(w.endpoint, :controller_name_id => c.id, :action_name_id => a.id)
    if !res.roles.include? 'Webmaster'
      role = Role.find_by_name('Webmaster')
      Interaction.create!([{:role_id => role.id, :controller_action_id => res.id}])
    end
  end
end

