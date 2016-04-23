class AddReference < ActiveRecord::Migration
  def change
  	change_table :hours do |t|
  		t.references :dining, polymorphic: true
  	end
  end
end
