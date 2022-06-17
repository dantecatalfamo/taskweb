json.extract! notebook, :id, :title, :created_at, :updated_at
json.url notebook_url(notebook, format: :json)
json.headings notebook.headings.top_level, partial: "headings/heading", as: :heading
