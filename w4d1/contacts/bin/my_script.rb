require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users.html',
).to_s

# puts RestClient.post(
#   url,
#   { user: { name: "Gizmo", email: "Gizmo@Gizmo.Gizmo" } }
#   )
#
# puts RestClient.patch(
#   "http://localhost:3000/users/1",
#   { user: { name: "Gizmo2", email: "Gizmo@GizmoGizmo.Gizmo" } }
# )

puts RestClient.delete("http://localhost:3000/users/1")
