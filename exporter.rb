require "erubis"
require "models"

class Exporter
  
	def self.themes
		tpl = Erubis::Eruby.new(File.read("template/theme.erb"))
		Theme.find(:all).each do |theme|
			p theme.name
			ctx = {}
			ctx[:theme] = theme
			ctx[:know] = theme.game.main.know
			File.open("export/#{theme.name}.txt", "w") do |file|
				file << tpl.evaluate(ctx)
			end
		end
	end

  
end