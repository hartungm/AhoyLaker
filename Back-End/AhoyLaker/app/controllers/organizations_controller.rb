class OrganizationsController < ApplicationController
    
    before_action :require_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
    before_action :require_admin, only: [:index, :new, :edit, :create, :update, :destroy]

    def index
        @organizations = Organization.all
        @users = User.all
    end
    
    def show
        @organization = Organization.find(params[:id])
    end

    def new
        @organization = Organization.new
    end

    def edit
        @organization = Organization.find(params[:id])
    end

    def create
        @organization = Organization.new(organization_params)

        if @organization.save
            redirect_to organizations_path
        else
            render 'new'
        end
    end

    def update
        @organization = Organization.find(params[:id])

        if @organization.update(organization_params)
            redirect_to organizations_path
        else
            render 'edit'
        end
    end

    def destroy
        @organization = Organization.find(params[:id])
        @organization.destroy

        redirect_to organizations_path
    end

    private
        def organization_params
            params.require(:organization).permit(:name, :org_type, :enabled, :logo)
        end
end
