Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
  config.log_level = :info
  config.server_middleware do |chain|
    chain.add MyCustomMiddleware
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
end
