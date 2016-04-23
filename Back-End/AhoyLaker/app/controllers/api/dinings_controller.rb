class Api::DiningsController < ApplicationController
	def index
		@organization = Organization.find(params[:organization_id])
		render json: @organization.dinings.all
	end
end