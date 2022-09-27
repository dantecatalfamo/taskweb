namespace :production do
  desc "TODO"
  task setup: :environment do
    Rake::Task["db:migrate"].invoke
    Rake::Task["assets:precompile"].invoke
  end

end
