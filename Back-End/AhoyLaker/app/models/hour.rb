class Hour < ActiveRecord::Base
	belongs_to :dining
	validates :title, presence: true
end
