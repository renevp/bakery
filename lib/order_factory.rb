require 'ostruct'

class OrderFactory
  MIN_ORDER_QTY = 1

  def initialize(order_data, order_class = Order, item_class=OrderItem)
    @order_data  = order_data
    @order_class = order_class
    @item_class  = item_class
  end

  def build
    @order_class.new(create_items())
  end

  private

  def create_items
    (@order_data.collect { |item| create_item(item) } ).compact
  end

  def create_item(item)
    @item_class.new(item[:quantity].to_i, item[:code]) if is_item_ok?(item)
  end

  def is_item_ok?(item)
    !(item[:code].strip.empty? || item[:quantity].to_i < MIN_ORDER_QTY)
  end
end
