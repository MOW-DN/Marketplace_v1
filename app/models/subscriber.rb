class Subscriber < ApplicationRecord
  belongs_to :product
  generates_token_for :unsubscribe

  def self.filter_by(params)
    results = all
    results = results.where(product_id: params[:product_id]) if params[:product_id].present?
    results
  end
end