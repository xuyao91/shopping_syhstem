class CartItem
  attr_reader :product
  attr_accessor :quantity
  def initialize(product)
    @product = product
    @quantity = 1
  end
  
  def increment_quantity
    @quantity = @quantity.to_i + 1
  end
  
  def name
    @product.name
  end
  
  def price
    @product.price*@quantity
  end
end