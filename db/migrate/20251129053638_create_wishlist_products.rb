class CreateWishlistProducts < ActiveRecord::Migration[8.1]
   def change
    create_table :wishlist_products do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :wishlist, null: false, foreign_key: true

      t.timestamps
    end

    add_index :wishlist_products, [:product_id, :wishlist_id], unique: true
  end
end
