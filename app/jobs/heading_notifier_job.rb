class HeadingNotifierJob < ApplicationJob
  queue_as :default

  def perform
    headings = Heading.dates_between(Time.now, 10.minutes.from_now)
    headings.each { |heading| PushoverNotifyJob.perform_later(heading) }
  end
end
