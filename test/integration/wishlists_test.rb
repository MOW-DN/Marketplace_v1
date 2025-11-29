require "test_helper"

class WishlistsTest < ActionDispatch::IntegrationTest
  test "create a wishlist" do
    user = users(:one)
    sign_in_as user
    assert_difference "user.wishlists.count" do
      post wishlists_path, params: { wishlist: { name: "Example" } }
      assert_response :redirect
    end
  end
  test "delete a wishlist" do
  user = users(:one)
  sign_in_as user
  assert_difference "user.wishlists.count", -1 do
    delete wishlist_path(user.wishlists.first)
    assert_redirected_to wishlists_path
  end
end
test "view a wishlist" do
  user = users(:one)
  wishlist = user.wishlists.first
  sign_in_as user
  get wishlist_path(wishlist)
  assert_response :success
  assert_select "h1", text: wishlist.name
end
test "view a wishlist as another user" do
  wishlist = wishlists(:two)
  sign_in_as users(:one)
  get wishlist_path(wishlist)
  assert_response :success
  assert_select "h1", text: wishlist.name
end
test "view a wishlist as a guest" do
  wishlist = wishlists(:one)
  get wishlist_path(wishlist)
  assert_response :success
  assert_select "h1", text: wishlist.name
end
test "add product to a specific wishlist" do
  sign_in_as users(:one)
  wishlist = wishlists(:one)
  assert_difference "WishlistProduct.count" do
    post product_wishlist_path(products(:shoes)), params: { wishlist_id: wishlist.id }
    assert_redirected_to wishlist
  end
end
test "add product when no wishlists" do
  user = users(:one)
  sign_in_as user
  user.wishlists.destroy_all
  assert_difference "Wishlist.count" do
    assert_difference "WishlistProduct.count" do
      post product_wishlist_path(products(:shoes))
    end
  end
end
test "cannot add product to another user's wishlist" do
  sign_in_as users(:one)
  assert_no_difference "WishlistProduct.count" do
    post product_wishlist_path(products(:shoes)), params: { wishlist_id: wishlists(:two).id }
    assert_response :not_found
  end
end
test "move product to another wishlist" do
  user = users(:one)
  sign_in_as user
  wishlist = user.wishlists.first
  wishlist_product = wishlist.wishlist_products.first
  second_wishlist = user.wishlists.create!(name: "Second Wishlist")
  patch wishlist_wishlist_product_path(wishlist, wishlist_product), params: { new_wishlist_id: second_wishlist.id }
  assert_equal second_wishlist, wishlist_product.reload.wishlist
end
 test "cannot move product to a wishlist that already contains product" do
    user = users(:one)
    sign_in_as user
    wishlist = user.wishlists.first
    wishlist_product = wishlist.wishlist_products.first
    second_wishlist = user.wishlists.create!(name: "Second")
    second_wishlist.wishlist_products.create(product_id: wishlist_product.product_id)
    patch wishlist_wishlist_product_path(wishlist, wishlist_product), params: { new_wishlist_id: second_wishlist.id }
    assert_equal "T-Shirt is already on Second.", flash[:alert]
    assert_equal wishlist, wishlist_product.reload.wishlist
  end
  test "cannot move product to another user's wishlist" do
    user = users(:one)
    sign_in_as user
    wishlist = user.wishlists.first
    wishlist_product = wishlist.wishlist_products.first
    patch wishlist_wishlist_product_path(wishlist, wishlist_product), params: { new_wishlist_id: wishlists(:two).id }
    assert_response :not_found
    assert_equal wishlist, wishlist_product.reload.wishlist
  end
  
end