require "erubis"

class Exporter
  
	def self.themes
		tpl = Erubis::Eruby.new(File.read("template/theme.erb"))
		Theme.find(:all).each do |theme|
			p theme.name
			ctx = {}
			ctx[:theme] = theme
			ctx[:know] = theme.games.main.know
			ctx[:unknow] = theme.games.main.unknow - ctx[:know]
			File.open("export/#{theme.name}.txt", "w") do |file|
				file << tpl.evaluate(ctx)
			end
		end
	end
	
	def self.stats
	  tpl = Erubis::Eruby.new(File.read("template/stats.erb"))
	  ctx = {}
	  ctx[:game_count] = Game.count
	  ctx[:themes] = Theme.find(:all)
	  ctx[:played_game] = Game.played.uniq.count
	  ctx[:member_count] = Member.count
	  ctx[:know_count] = Game.know.count
	  File.open("export/stats.txt", "w") do |file|
			file << tpl.evaluate(ctx)
		end
	end

  
end