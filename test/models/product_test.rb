require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should save valid product" do
    product = Product.new(
      title: "Tastiera Meccanica",
      description: "Ottima tastiera per programmare",
      price: 120.50
    )
    assert product.save, "Non è riuscito a salvare un prodotto valido"
  end

  test "should not save product without title" do
    product = Product.new(price: 10.0)
    assert_not product.save, "Ha salvato il prodotto senza un titolo!"
  end
end