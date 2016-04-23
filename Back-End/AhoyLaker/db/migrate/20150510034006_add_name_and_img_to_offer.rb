class AddNameAndImgToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :name, :string
    add_column :offers, :image_url, :string
  end
end
