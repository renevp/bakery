class Products
  attr_accessor :products

  def initialize(products)
    @products = products
  end

  def filter(code)
    products.select {|product| product.code == code}
  end

  def size
    products.size
  end
end
