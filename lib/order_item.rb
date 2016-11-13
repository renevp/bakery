class OrderItem
  MIN_QTY = 1

  attr_accessor :quantity, :code

  def initialize(quantity, code)
    self.quantity = quantity
    self.code     = code
  end

  def quantity=(quantity)
    if quantity == nil || quantity.to_i < MIN_QTY
      raise ArgumentError.new(" Quantity must be greater than '#{MIN_QTY}' ")
    end
    @quantity = quantity.to_i
  end

  def code=(code)
    if code == nil || code.strip.empty?
      raise ArgumentError.new(" Invalid product code '#{code}' ")
    end
    @code = code
  end

  def to_s
    "code: #{code}, quantity: #{quantity}"
  end
end
