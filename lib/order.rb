class Order
  attr_accessor :order_items

  def initialize(order_items)
    @order_items = order_items
  end
end
