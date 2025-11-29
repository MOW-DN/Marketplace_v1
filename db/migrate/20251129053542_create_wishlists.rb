class CreateWishlists < ActiveRecord::Migration[8.1]
  def change
    create_table :wishlists do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.integer :products_count, default: 0

      t.timestamps
    end
  end
end
