class Api::OffersController < ApplicationController
	def index
		@organization = Organization.find(params[:organization_id])
		render json: @organization.offers.all
	end
end