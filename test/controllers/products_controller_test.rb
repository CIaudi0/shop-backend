require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = Product.create!(
      title: "Mouse Wireless",
      description: "Mouse ergonomico",
      price: 25.99
    )
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should filter products by search query" do
    get products_url, params: { q: "mouse" }
    
    assert_response :success
    
    json_response = JSON.parse(response.body)
    
    assert_equal 1, json_response.length
    assert_equal "Mouse Wireless", json_response.first["title"]
  end
end