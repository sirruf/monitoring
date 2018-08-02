require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/cron/web'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://127.0.0.1:6379/0', namespace: "sidekiq_monitoring_#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://127.0.0.1:6379/0', namespace: "sidekiq_monitoring_#{Rails.env}" }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == %w(test test)
end

schedule_file = 'config/schedule.yml'

if File.exists?(schedule_file)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
