class RemoveExtraUserFields < ActiveRecord::Migration
  def change
  	remove_column :users, :login_count, :integer
    remove_column :users, :failed_login_count, :integer
    remove_column :users, :last_request_at, :datetime
    remove_column :users, :current_login_at, :datetime
    remove_column :users, :last_login_at, :datetime
    remove_column :users, :current_login_ip, :string
    remove_column :users, :last_login_ip, :string
    remove_column :users, :password_salt, :string
    remove_column :users, :persistence_token, :string
    remove_column :users, :crypted_password, :string
  	remove_column :users, :password_field, :string
  end
end
