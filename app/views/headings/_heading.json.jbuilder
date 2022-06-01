json.extract! heading, :id, :title, :body, :status, :deadline, :scheduled, :created_at, :updated_at
json.url heading_url(heading, format: :json)
json.headings heading.headings, partial: "headings/heading", as: :heading
