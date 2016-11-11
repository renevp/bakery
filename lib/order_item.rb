class OrderItem
  attr_accessor :quantity, :code

  def initialize(quantity, code)
    @quantity = quantity
    @code     = code
  end
end
