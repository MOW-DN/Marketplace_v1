class Wishlists::WishlistProductsController < ApplicationController
  before_action :set_wishlist
  before_action :set_wishlist_product

  def destroy
    @wishlist_product.destroy
    redirect_to @wishlist, notice: "#{@wishlist_product.product.name} removed from wishlist."
  end
 def update
    new_wishlist = Current.user.wishlists.find(params[:new_wishlist_id])
    if @wishlist_product.update(wishlist: new_wishlist)
      redirect_to @wishlist, status: :see_other, notice: "#{@wishlist_product.product.name} has been moved to #{new_wishlist.name}"
    else
      redirect_to @wishlist, status: :see_other, alert: "#{@wishlist_product.product.name} is already on #{new_wishlist.name}."
    end
  end

  private

  def set_wishlist
    @wishlist = Current.user.wishlists.find_by(id: params[:wishlist_id])
  end

  def set_wishlist_product
    @wishlist_product = @wishlist.wishlist_products.find(params[:id])
  end
end