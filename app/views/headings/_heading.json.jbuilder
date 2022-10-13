json.extract! heading, :id, :title, :body, :state, :org_id, :deadline, :scheduled, :created_at, :updated_at, :closed_at, :properties
json.url heading_url(heading, format: :json)
json.properties heading.properties, partial: "heading_properties/heading_property", as: :heading_property, cached: true
if params[:shallow]
  json.children heading.children.map { |child| heading_url(child, format: :json) }
else
  json.children heading.children, partial: "headings/heading", as: :heading, cached: true
end
