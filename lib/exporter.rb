require "erubis"

class Exporter
  class UnknowReport < RuntimeError; end
  
  
  def initialize(template_path)
    @template_path = template_path || "../template"
  end
  
  
  def method_missing(symbol)
      meth = self.extract_method(symbol)
      tpl = self.extract_template_for(mth)
      new_meth = compile_method(meth, tpl)
      self.send(symbol)
  end
	
	
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
	
  private
  
  def find_template
    
  end
  
  #extract the method in charge of fetching the data for the report
  #
  # only accept meth starting with render_*
  def extract_method(name)
    raise UnknowReport unless name.start_with?("render_")
    
  end
  
  def compile_method
    
  end
  
  
end