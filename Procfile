web: bundle exec puma -C config/puma.rb -b tcp://0.0.0.0:$PORT
worker: bundle exec rake solid_queue:start
release: bundle exec rails db:migrate