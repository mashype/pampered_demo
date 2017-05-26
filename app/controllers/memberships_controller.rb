class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @memberships = Membership.all
  end

  def show
  end

  def new
    @membership = Membership.new
  end

  def edit
  end

  def create
    @membership = Membership.new membership_params.merge(email: stripe_params["stripeEmail"], card_token: stripe_params["stripeToken"])
    @membership.user_id = current_user.id
    raise "Please, check registration errors" unless @membership.valid?
    @membership.process_payment stripe_params['stripeToken']
    @membership.save

    redirect_to root_path

  rescue Exception => e
    flash[:error] = e.message
    render :new
  end




  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to memberships_url, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_membership
      @membership = Membership.find(params[:id])
    end

    def stripe_params
      params.permit :stripeEmail, :stripeToken, :utf8, :authenticity_token, :stripeTokenType
    end

    def membership_params
      params.require(:membership).permit(:total_credits, :used_credits, :email, :card_token, :user_id)
    end
end

