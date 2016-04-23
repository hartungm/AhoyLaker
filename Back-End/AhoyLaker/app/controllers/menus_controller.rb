class MenusController < ApplicationController
    
    before_action :require_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]

    def index
        @menus = Menu.all
    end
    
    def show
        @menu = Menu.find(params[:id])
    end

    def new
        @organization = Organization.find(params[:organization_id])
        @dining = @organization.dinings.find(params[:dining_id])
        @menu = @dining.menus.new
    end

    def edit
        @organization = Organization.find(params[:organization_id])
        @dining = @organization.dinings.find(params[:dining_id])
        @menu = @dining.menus.find(params[:id])
    end

    def create
        puts :items
        @organization = Organization.find(params[:organization_id])
        @dining = Dining.find(params[:dining_id])
        @menu = @dining.menus.create(menu_params)

        if @menu.save
            redirect_to organization_dining_path(@organization, @dining)
        else
            render 'new'
        end
    end

    def update
        @organization = Organization.find(params[:organization_id])
        @dining = Dining.find(params[:dining_id])
        @menu = @dining.menus.find(params[:id])

        if @menu.update(menu_params)
            redirect_to organization_dining_path(@organization, @dining)
        else
            render 'edit'
        end
    end

    def destroy
       @organization = Organization.find(params[:organization_id])
        @dining = Dining.find(params[:dining_id])
        @menu = @dining.menus.find(params[:id])
        @menu.destroy

        redirect_to organization_dining_path(@organization, @dining)
    end

    private
        def menu_params
            params.require(:menu).permit(:section_title, :items)
        end
end