require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/cron/web'

if ENV['REDIS_URL']
  $redis = ENV['REDIS_URL']
else
  $redis = 'redis://127.0.0.1:6379/0'
end

Sidekiq.configure_server do |config|
  config.redis = { url: $redis, namespace: "sidekiq_monitoring_#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: $redis, namespace: "sidekiq_monitoring_#{Rails.env}" }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == %w(test test)
end

schedule_file = 'config/schedule.yml'

if File.exists?(schedule_file)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
