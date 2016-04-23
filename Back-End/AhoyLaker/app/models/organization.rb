class Organization < ActiveRecord::Base
	has_many :offers, dependent: :destroy
	has_many :dinings, dependent: :destroy
	has_many :users, dependent: :destroy
	has_attached_file :logo, :styles => { :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	validates :name, presence: true
	validates :org_type, presence: true
	validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

	def logo_url
		logo.url(:thumb)
	end
end
