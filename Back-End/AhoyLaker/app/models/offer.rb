class Offer < ActiveRecord::Base
  belongs_to :organization
  validates :name, presence: true
  validates :description, presence: :true
  validates :promo_details, presence: :true
  validates :coupon_code, presence: :true
end
