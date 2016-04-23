class Menu < ActiveRecord::Base
	belongs_to :dining
	validates :section_title, presence: true
end
