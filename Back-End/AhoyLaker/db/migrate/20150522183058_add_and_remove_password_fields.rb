class AddAndRemovePasswordFields < ActiveRecord::Migration
  def change
      remove_column :users, :password, :string
      add_column :users, :crypted_password, :string
      add_column :users, :password_field, :string
  end
end
