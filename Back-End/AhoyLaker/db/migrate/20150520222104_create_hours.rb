class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.string :title
      t.string :data

      t.timestamps null: false
    end
    remove_column :dinings, :hours
    remove_column :dinings, :menu
  end
end
