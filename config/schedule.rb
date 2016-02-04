# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, "production"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
set :bundle_command, "/app/vendor/bundle/bin/bundle exec"

every 1.day, :at => '12 am' do
	rake "quandl_task:update_price"
end
