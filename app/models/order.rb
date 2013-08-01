class Order < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :product
  belongs_to :user
  
  validates_numericality_of :total_price
  
  def self.for_product
    item = self.new
    item.count = 1
    item.product = product
    item.total_price = product.price
    item
  end
  
  def self.delete_products(ids)
    if ids.present?
      flag = true
      @orders = Order.find(:all,:conditions=>["id in(?)",ids])
      @orders.each do |order|
      order.destroy
      end
    else
      flag = false
    end        
  end
  
end
