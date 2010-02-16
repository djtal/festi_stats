require "rubygems"


  
namespace :db do
  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
  
	desc "setup connection for active record"
	task (:environment) do
		require "activerecord"
		ActiveRecord::Base.establish_connection(YAML.load(File.open("db/config.yml")))
	end
  
  desc "import"
  task(:import_base_data => :environment) do
	require "importer"
	Importer.flush
	Importer.import_base
	Importer.import_played
  end
  
  task(:import_survey => :environment) do
	require "importer"
	Importer.import_survey_results
  end
end
