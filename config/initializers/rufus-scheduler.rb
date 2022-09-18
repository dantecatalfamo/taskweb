require 'rufus-scheduler'

return if defined?(Rails::Console) || Rails.env.test? || File.split($PROGRAM_NAME).last == 'rake'

#
# do not schedule when Rails is run from its console, for a test/spec, or
# from a Rake task

# return if $PROGRAM_NAME.include?('spring')
#
# see https://github.com/jmettraux/rufus-scheduler/issues/186

rufus = Rufus::Scheduler.singleton

rufus.every '10m' do
  Rails.logger.info 'Running HeadingNotifierJob'
  HeadingNotifierJob.perform_later
end
