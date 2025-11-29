class AddWishlistsCountToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :wishlists_count, :integer , default: 0
  end
end
