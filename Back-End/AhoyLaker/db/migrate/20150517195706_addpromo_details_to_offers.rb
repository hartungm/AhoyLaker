class AddpromoDetailsToOffers < ActiveRecord::Migration
  def change
  	add_column :offers, :promo_details, :string
  end
end
