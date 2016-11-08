class OrderProcessing
  attr_accessor :order, :products

  def initialize(order, products)
    @order = order
    @products = products
  end

  def resolve
    print '10 VS5 $17.98 - 2 x 5 $8.99'
  end
end
