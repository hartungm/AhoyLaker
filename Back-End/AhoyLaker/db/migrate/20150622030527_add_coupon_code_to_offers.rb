class AddCouponCodeToOffers < ActiveRecord::Migration
  def change
  	add_column :offers, :coupon_code, :string
  end
end
