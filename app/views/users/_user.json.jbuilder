json.extract! user, :id, :username, :created_at, :updated_at, :admin
json.url user_url(user, format: :json)
