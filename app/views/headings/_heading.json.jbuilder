json.extract! heading, :id, :title, :body, :state, :org_id, :deadline, :scheduled, :created_at, :updated_at, :closed_at
json.url heading_url(heading, format: :json)
if params[:shallow]
  json.children heading.children.map { |child| heading_url(child, format: :json) }
else
  json.children heading.children, partial: "headings/heading", as: :heading
end
