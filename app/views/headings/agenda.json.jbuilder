json.array! @agenda_dates do |date|
  json.date date.date
  json.headings date.headings do |heading|
    json.extract! heading, :id, :title, :body, :state, :deadline, :scheduled, :created_at, :updated_at, :closed_at
    json.url heading_url(heading, format: :json)
  end
end
