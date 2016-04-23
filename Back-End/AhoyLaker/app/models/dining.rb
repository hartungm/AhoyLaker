class Dining < ActiveRecord::Base
  belongs_to :organization
  has_many :hours, dependent: :destroy
  has_many :menus, dependent: :destroy
  validates :name, presence: true
  validates :location, presence: true
end
