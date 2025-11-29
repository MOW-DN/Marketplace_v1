require "test_helper"

class WishlistTest < ActiveSupport::TestCase
  test "filter_by with no filters" do
    assert_equal Wishlist.all, Wishlist.filter_by({})
  end

  test "filter_by with user_id" do
    wishlists = Wishlist.filter_by(user_id: users(:one).id)
    assert_includes wishlists, wishlists(:one)
    assert_not_includes wishlists, wishlists(:two)
  end

  test "filter_by with product_id" do
    wishlists = Wishlist.filter_by(product_id: products(:shoes).id)
    assert_includes wishlists, wishlists(:two)
    assert_not_includes wishlists, wishlists(:one)
  end
end