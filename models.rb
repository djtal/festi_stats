  
class Game < ActiveRecord::Base
	belongs_to :theme
	has_many :survey_results
	has_many :members, :through => :survey_results
end
 
class Member < ActiveRecord::Base
	has_many :survey_results
	has_many :games , :through => :survey_results
end
 
class SurveyResult < ActiveRecord::Base
	belongs_to :game
	belongs_to :member
	
	named_scope :know, :conditions => {:level => 2}
	named_scope :played, :conditions => {:level => 1}
end

class Theme < ActiveRecord::Base
	has_many :games
end
 