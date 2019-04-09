class Admin::MerchantsController < Admin::BaseController

  def show
    @user = User.find(params[:id])
    redirect_to admin_user_path(@user) if @user.user?
  end

  def update
    if params[:disable]
      merchant = User.find(params[:id])
      merchant.disable_merchant_items
      merchant.update(enabled: false)
      flash[:merchant_disabled] = "#{merchant.name} is now disabled"
      redirect_to merchants_path
    elsif !params[:disable]
      merchant = User.find(params[:id])
      # need to write enable merch items 
      merchant.disable_merchant_items
      merchant.update(enabled: true)
      flash[:merchant_disabled] = "#{merchant.name} is now enabled"
      redirect_to merchants_path
    else
      user_to_be_updated = User.find(params[:id])
      user_to_be_updated.disable_merchant_items
      user_to_be_updated.update(role: 0)
      flash[:notice] = "Merchant #{user_to_be_updated.name} downgraded"
      redirect_to admin_user_path(user_to_be_updated)
    end
  end
end
