class DiningsController < ApplicationController

	before_action :require_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]

    def index
        @dinings = Dining.all
    end

    def show
        @organization = Organization.find(params[:organization_id])
        @dining = Dining.find(params[:id])
    end
    
    def new
        @dining = Dining.new
    end

    def edit
        @organization = Organization.find(params[:organization_id])
        @dining = Dining.find(params[:id])
    end

    def create
        @organization = Organization.find(params[:organization_id])
        @dining = @organization.dinings.create(dining_params)
        if @dining.hours.all.count < 7
            days_of_week = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
            days_of_week.each do |day|
                hours_entry = @dining.hours.create({:title => day, :data => '9am - 5pm'})
                if hours_entry.save
                    puts 'Hours Saved!'
                else
                    puts 'Error Saving Hours!'
                end
            end
        end
        if @dining.save
            redirect_to organization_path(@organization)
        else
            render 'new'
        end
    end

    def update
        @organization = Organization.find(params[:organization_id])
        @dining = @organization.dinings.find(params[:id])

        if @dining.update(dining_params)
            redirect_to '/organizations/' + @dining.organization_id.to_s + '/'
        else
            render 'edit'
        end
    end

    def destroy
        @dining = Dining.find(params[:id])
        @dining.destroy

        redirect_to organization_path(params[:organization_id])
    end

    private
        def dining_params
            params.require(:dining).permit(:name, :location)
        end

end
