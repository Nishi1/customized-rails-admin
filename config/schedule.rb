# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
# set :output, "/var/www/html/sweep-media/log/cron.log"
# set :environment, "development"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
# RAILS_ROOT = File.expand_path(File.dirname(__FILE__) + '/')
every 30.minute do
  # runner "AdminMailer.user_notification.deliver"
  runner "AdminMailer.user_notification.deliver", :output => {:error => 'log/error.log', :standard => 'log/success.log'}
end

# Learn more: http://github.com/javan/whenever
