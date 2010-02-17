class Game < ActiveRecord::Base
	has_one :theme_game
	has_one :theme, :through => :theme_game
	has_many :survey_results
	has_many :members, :through => :survey_results
	
	
	named_scope :know, :include => :survey_results, :conditions => {:survey_results => {:level => 2}}
	named_scope :played, :include => :survey_results, :conditions => {:survey_results => {:level => 1}}
	named_scope :unknow, :include => :survey_results, :conditions => {:survey_results => {:level => 0}}
	
	named_scope :main, :include => :theme_game, :conditions => {:theme_games => {:main => true}}
	named_scope :secondary, :include => :theme_game, :conditions => {:theme_games => {:main => false}}
end
 
class Member < ActiveRecord::Base
	has_many :survey_results
	has_many :games , :through => :survey_results
end
 
class SurveyResult < ActiveRecord::Base
	belongs_to :game
	belongs_to :member
end

class Theme < ActiveRecord::Base
	has_many :theme_games
	has_many :games, :through => :theme_games
end

class ThemeGame < ActiveRecord::Base
	belongs_to :game
	belongs_to :theme
end
 