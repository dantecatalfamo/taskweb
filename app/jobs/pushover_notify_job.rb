class PushoverNotifyJob < ApplicationJob
  queue_as :default

  def perform(heading)
    PushoverHeading.call(heading)
  end
end
