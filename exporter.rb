require "erubis"


class Exporter
  
  def export_member_per_game
    ctx = {}
    
    
    tpl = Erubis::Eruby.new(File.read("template/member_per_game.erb"))
    File.open("export/member_per_game", "w") do |file|
      tpl.evaluate(ctx)
    end
  end
  
end