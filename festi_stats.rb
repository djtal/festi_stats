require "rubygems"
require "activerecord"
require "models"

class FestiStats
  def self.connect
    ActiveRecord::Base.establish_connection(YAML.load(File.open("db/config.yml")))
  end
end


