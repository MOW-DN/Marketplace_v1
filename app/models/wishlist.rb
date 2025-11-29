class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :wishlist_products, dependent: :destroy
  has_many :products, through: :wishlist_products

  to_param :name

  def self.filter_by(params)
    results = all
    results = results.where(user_id: params[:user_id]) if params[:user_id].present?
    results = results.includes(:wishlist_products).where(wishlist_products: {product_id: params[:product_id]}) if params[:product_id].present?
    results
  end
end