require "models"
require "csv"
require "logger"
require "roo"


class Importer

	def self.flush
		Game.destroy_all
		Theme.destroy_all
	end

	def self.import_base
		CSV::Reader.parse(File.open('import/base.csv', 'r'), ";") do |row|
			theme = Theme.find(:first, :conditions => {:name => row[0]})
			theme = Theme.create(:name => row[0]) if !theme
			game = Game.create(:name => row[1])
			theme.games << game
			theme.save
		end
	end
	
	def	self.import_played
		
		CSV::Reader.parse(File.open('import/played_own.csv', 'r')) do |row|
			g = Game.find(:first, :conditions => {:name => row[0]})
			if (g)
				g.played_count  = row[1].to_i
				g.save
			end
		end	
	end
	
	def self.import_survey_results
		SurveyResult.destroy_all
		Member.destroy_all
		Dir.glob("import/survey/*.xls").each do |file|
			excel = Excel.new(file)
			if excel
				member = Member.find_or_create_by_name(excel.cell(1,"B").to_s)
				5.upto(93) do |line|
					game = Game.find_by_name(excel.cell(line, "A"))
					if (game)
						member.survey_results.create(:game => game, :level => excel.cell(line, "B"))
					end
				
				end
			end

		end
	end

end
