json.extract! notebook, :id, :title, :created_at, :updated_at
json.url notebook_url(notebook, format: :json)
