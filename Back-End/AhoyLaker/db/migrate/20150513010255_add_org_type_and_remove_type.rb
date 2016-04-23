class AddOrgTypeAndRemoveType < ActiveRecord::Migration
  def change
  	add_column :organizations, :org_type, :integer
  	remove_column :organizations, :type, :integer
  end
end
