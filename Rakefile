require './model.rb'

task :default => [:upgrade]

task :upgrade do
  DataMapper.auto_upgrade!
end

task :migrate do
  DataMapper.auto_migrate!
end
