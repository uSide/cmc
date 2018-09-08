require_relative 'config/environment'

task default: %w[worker]

task :seed do
  require_relative 'db/seeds'
end

task :worker do
  loop do
    Pulls::Fetch.perform
    Pulls::Refresh.perform
    sleep 60 * 10
  end
end
