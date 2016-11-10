require 'ostruct'

module OrderFactory
  MIN_ORDER_QTY = 1

  def self.build(order_data, order_class = Order)
    order_class.new( ( order_data.collect { |item| create_item(item) } ).compact )
  end

  def self.create_item(item)
    unless item[:code].strip.empty? || item[:quantity].to_i < MIN_ORDER_QTY
      OpenStruct.new(
        code:     item[:code],
        quantity: item[:quantity].to_i)
      end
    end
end
