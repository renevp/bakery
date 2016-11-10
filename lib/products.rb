require 'ostruct'

module ProductsPacksFactory
  MIN_QTY_PER_PACK = 1

  def self.build(products_data, packs_data, products_class = Products)
    products = Array.new
    products_data.each do |product|
      products << Product.new(product[:name], product[:code],
        (packs_data.collect {|pack| create_pack(pack, product) }).compact)
    end
    products_class.new(products)
  end

  def self.create_pack(pack, product)
    unless pack[:code] != product[:code] ||
      pack[:quantity].to_i < MIN_QTY_PER_PACK ||
      pack[:code].strip.empty? ||
      product[:code].strip.empty?
      OpenStruct.new(
        code:     pack[:code],
        quantity: pack[:quantity].to_i,
        price:    pack[:price].to_f)
    end
  end
end

class Product
  attr_accessor :name, :code, :packs

  def initialize(name, code, packs)
    @name = name
    @code = code
    @packs = packs
  end
end

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
