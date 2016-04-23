class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :url
      t.string :doc
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
