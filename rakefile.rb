require "festi_stats"


task(:setup => "db:destroy") do
	require "fileutils"
	mkdir("log") unless File.exist?("log")
	Rake::Task['db:migrate'].invoke
	Rake::Task['import:base'].invoke
	Rake::Task['import:survey'].invoke
end

namespace :db do
	desc "Migrate the database"
	task(:migrate => :environment) do
		ActiveRecord::Base.logger = Logger.new("log/ar.log")
		ActiveRecord::Migration.verbose = true
		ActiveRecord::Migrator.migrate("db/migrate")
	end
  
	desc "setup connection for active record"
	task (:environment) do
		FestiStats.connect
	end
	
	desc "remove database"
	task(:destroy) do
		conect = YAML.load(File.read("db/config.yml")) 
		File.delete(conect["database"]) if File.exist?(conect["database"])
	end
end

namespace :import do
	desc "import"
	task(:base => "db:environment") do
		Importer.flush
		Importer.import_base
		Importer.import_played
	end
	
	task(:survey => "db:environment") do
		Importer.import_survey_results
	end
end

namespace :export do
	desc "export one card per theme"
	task(:themes => "db:environment") do
		Exporter.themes
	end
	
	desc "export some stats about gathered data"
	task(:stats => "db:environment") do
	  Exporter.stats
	end
	
	task(:all) do
	  Rake::Task['export:stats'].invoke
	  Rake::Task['export:themes'].invoke
	end
end
