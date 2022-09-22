json.array! @agenda_dates do |date|
  json.date date.date
  json.headings date.headings do |heading|
    json.extract! heading, :id, :title, :body, :state, :deadline, :scheduled, :created_at, :updated_at, :closed_at, :org_id
    json.overdue (heading.deadline && heading.deadline < Time.now) || (heading.scheduled && heading.scheduled < Time.now) || false
    json.url heading_url(heading, format: :json)
  end
end
