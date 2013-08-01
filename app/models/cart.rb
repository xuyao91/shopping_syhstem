class Cart
  attr_accessor :items, :quantity
  
  def initialize
    @items = []
  end
  
  # If the product in cart no will add to cart
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-01
  def add_product(product)
    current_item = @items.find{|item| item.product == product}
    if current_item
      current_item.increment_quantity
    else
      @items << CartItem.new(product)
    end
    product.quantity -= 1
    product.save!
  end

  # delete the product in the cart
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-01
  def delete_product(id)
    product = Product.find(:first,:conditions=>["id = ?",id])
    current_item = @items.find{|item| item.product.id == id}
    @items.delete(current_item)
    product.quantity += current_item.quantity.to_i
    product.save!
  end
  
end