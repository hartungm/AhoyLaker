class Api::HoursController < ApplicationController
	def index
		@dining = Dining.find(params[:dining_id])
		render json: @dining.hours.all
	end
end