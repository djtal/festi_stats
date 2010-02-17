class BaseData < ActiveRecord::Migration
	def self.up
		create_table :games do |t|
			t.string  :name
			t.integer :played_count
			t.belongs_to :theme
		end
		
		create_table :themes do |t|
			t.string :name
			t.has_many :games
		end
		
		create_table :members do |t|
			t.string :name
			t.has_many :survey_results
		end
		
		create_table :survey_results do |t|
			t.belongs_to :game
			t.belongs_to :member
			t.integer 	:level
		end
	end

	def self.down
	  
	end
end
