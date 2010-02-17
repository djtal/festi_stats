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
		require "importer"
		Importer.flush
		Importer.import_base
		Importer.import_played
	end
	
	task(:survey => "db:environment") do
		require "importer"
		Importer.import_survey_results
	end
end

namespace :export do
	desc "export one card per theme"
	task(:themes => "db:environment") do
		require "exporter"
		Exporter.themes
	end
end
