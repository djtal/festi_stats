class AddThemeStatus < ActiveRecord::Migration
	def self.up
		remove_column :games, :theme_id
		create_table :theme_games do |t|
			t.belongs_to :game
			t.belongs_to :theme
			t.boolean :main
		end
	end
end