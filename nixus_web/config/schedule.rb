RAILS_ROOT = File.dirname(__FILE__) + '/..'
set :output, "#{path}/log/whenever.log"

every 5.minutes do
	rake "nixus:tasks:reg_all_update_host_info"
end

every :day, :at => '00:00am' do
	rake "nixus:housekeeping:reg_all_update_host_info"
end

