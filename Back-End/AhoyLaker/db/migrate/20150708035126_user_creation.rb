class UserCreation < ActiveRecord::Migration
  def change
  	remove_column :users, :organization_id, :integer, references: :organizations
  	remove_column :users, :email, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :email, :string
  	add_column :users, :password_digest, :string
  	add_column :users, :organization_id, :integer, references: :organizations
  end
end
