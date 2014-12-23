require "rake"

namespace :answers do

  desc "example_task"
  task :example_task => :environment do
    p "Example task has completed... success!"
  end

end