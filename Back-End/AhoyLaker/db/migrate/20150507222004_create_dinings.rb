class CreateDinings < ActiveRecord::Migration
  def change
    create_table :dinings do |t|
      t.string :name
      t.string :menu
      t.string :hours
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
