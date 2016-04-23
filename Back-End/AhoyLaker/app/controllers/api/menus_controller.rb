class Api::MenusController < ApplicationController
	def index
		@dining = Dining.find(params[:dining_id])
		render json: @dining.menus.all
	end
end