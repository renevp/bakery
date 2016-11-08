require 'ostruct'

module OrderFactory
  def self.build(order_data, order_class = Order)
    order_class.new(order_data.collect { |item| create_item(item) })
  end

  def self.create_item(item)
    OpenStruct.new(
      code:     item[:code],
      quantity: item[:quantity])
  end
end

class Order
  attr_accessor :order_items

  def initialize(order_items)
    @order_items = order_items
  end
end
