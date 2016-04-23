class OffersController < ApplicationController

    before_action :require_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]

	def index
        @offers = Offer.all
    end

    def show
        @organization = Organization.find(params[:organization_id])
        @offer = @organization.offers.find(params[:id])
    end
    
    # def new
    #     @offer = Offer.new
    # end

    def edit
        @organization = Organization.find(params[:organization_id])
        @offer = @organization.offers.find(params[:id])
    end

    def create
        @organization = Organization.find(params[:organization_id])
        @offer = @organization.offers.create(offer_params)

        if @offer.save
            redirect_to organization_path(@organization)
        else
            render 'new'
        end
    end

    def update
        @organization = Organization.find(params[:organization_id])
        @offer = @organization.offers.find(params[:id])

        if @offer.update(offer_params)
            redirect_to organization_path(@organization)
        else
            render 'edit'
        end
    end

    def destroy
        @organization = Organization.find(params[:organization_id])
        @offer = Offer.find(params[:id])
        @offer.destroy

        redirect_to organization_path(@organization)
    end

    private
        def offer_params
            params.require(:offer).permit(:name, :description, :promo_details, :coupon_code)
        end
end
