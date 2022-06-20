json.extract! heading, :id, :title, :body, :state, :deadline, :scheduled, :created_at, :updated_at, :closed_at
json.url heading_url(heading, format: :json)
json.children heading.children, partial: "headings/heading", as: :heading
