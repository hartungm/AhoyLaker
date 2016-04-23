class Api::OrganizationsController < ApplicationController
	def index
		render json: Organization.all, :methods => [:logo_url]
	end
end