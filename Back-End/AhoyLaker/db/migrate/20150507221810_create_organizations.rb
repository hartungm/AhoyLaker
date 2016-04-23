class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :org_type
      t.boolean :enabled

      t.timestamps null: false
    end
  end
end
