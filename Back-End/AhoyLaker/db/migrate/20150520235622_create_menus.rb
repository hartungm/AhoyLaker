class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :section_title
      t.string :items

      t.timestamps null: false
    end
    change_table :menus do |t|
  		t.references :dining, polymorphic: true
  	end
  end
end
