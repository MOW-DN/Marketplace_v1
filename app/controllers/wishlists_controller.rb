class WishlistsController < ApplicationController
  allow_unauthenticated_access only: %i[ show ]
  before_action :set_wishlist, only: %i[ edit update destroy ]

  def index
    @wishlists = Current.user.wishlists
  end

  def show
    @wishlist = Wishlist.find(params[:id])
  end

  def new
    @wishlist = Wishlist.new
  end

  def create
    @wishlist = Current.user.wishlists.new(wishlist_params)
    if @wishlist.save
      redirect_to @wishlist, notice: "Your wishlist was created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @wishlist.update(wishlist_params)
      redirect_to @wishlist, status: :see_other, notice: "Your wishlist has been updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @wishlist.destroy
    redirect_to wishlists_path, status: :see_other
  end

  private

  def set_wishlist
    @wishlist = Current.user.wishlists.find(params[:id])
  end

  def wishlist_params
    params.expect(wishlist: [ :name ])
  end
end