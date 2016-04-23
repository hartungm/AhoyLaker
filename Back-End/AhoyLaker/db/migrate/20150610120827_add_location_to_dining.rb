class AddLocationToDining < ActiveRecord::Migration
  def change
  	add_column :dinings, :location, :string
  end
end
