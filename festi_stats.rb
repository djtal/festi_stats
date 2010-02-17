require "rubygems"
require "activerecord"
require "lib/models"
require "lib/importer"
require "lib/exporter"

class FestiStats
  def self.connect
    ActiveRecord::Base.establish_connection(YAML.load(File.open("db/config.yml")))
  end
end


