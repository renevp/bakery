require 'ostruct'

module OrderFactory
  MIN_ORDER_QTY = 1

  def self.build(order_data, order_class = Order, item_class=OrderItem)
    order_class.new( create_items(order_data, item_class))
  end

  def self.create_items(order_data, item_class)
    (order_data.collect { |item| create_item(item, item_class) } ).compact
  end

  def self.create_item(item, item_class)
    unless item[:code].strip.empty? || item[:quantity].to_i < MIN_ORDER_QTY
      item_class.new(item[:quantity].to_i, item[:code])
    end
  end
end
