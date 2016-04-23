class UsersController < ApplicationController
  
    #before_action :require_admin, only: [ :new, :create, :edit, :update, :destroy ]


    def new
        @user = User.new
        @organizations = Organization.all
    end

    def create 
      @user = User.new(user_params) 
      if @user.save 
        redirect_to '/organizations' 
      else 
        redirect_to '/signup'
      end 
    end

    def edit
      @user = User.find(params[:id])
      @organizations = Organization.all
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to organizations_path
        else
            render 'edit'
        end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      redirect_to organizations_path
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :password, :is_admin, :organization_id)
        end

end
