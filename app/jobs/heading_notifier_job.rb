class HeadingNotifierJob < ApplicationJob
  queue_as :default

  def perform
    headings = Heading.not_todo_or_done.dates_between(Time.now, 10.minutes.from_now)
    headings.each { |heading| PushoverNotifyJob.perform_later(heading) }
  end
end
