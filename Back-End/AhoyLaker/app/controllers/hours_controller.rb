class HoursController < ApplicationController
    
    before_action :require_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]

    def index
        @hours = Hour.all
    end
    
    def show
        @hour = Hour.find(params[:id])
    end

    def new
        @hour = Hour.new
    end

    def edit
        @organization = Organization.find(params[:organization_id])
        @dining = @organization.dinings.find(params[:dining_id])
        @hour = @dining.hours.find(params[:id])
    end

    def create
        @hour = Hour.new(hour_params)

        if @hour.save
            redirect_to hours_path
        else
            render 'new'
        end
    end

    def update
        @organization = Organization.find(params[:organization_id])
        @dining = Dining.find(params[:dining_id])
        @hour = @dining.hours.find(params[:id])

        if @hour.update(hour_params)
            redirect_to organization_dining_path(@organization, @dining)
        else
            render 'edit'
        end
    end

    def destroy
        @hour = Hour.find(params[:id])
        @orgnization.destroy

        redirect_to hours_path
    end

    private
        def hour_params
            params.require(:hour).permit(:title, :data)
        end
end