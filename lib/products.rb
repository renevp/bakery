require 'ostruct'

module ProductsPacksFactory
  MIN_QTY_PER_PACK = 1

  def self.build(products_data, packs_data)
    products = products_data.collect do |product|
      create_product(packs_data, product)
    end
    Products.new(products) if products.count > 0
  end

  private

  def self.create_product(packs_data, product)
    Product.new(product[:name], product[:code], create_packs(packs_data, product))
  end

  def self.create_packs(packs_data, product)
    (packs_data.collect { |pack| create_pack(pack, product) }).compact
  end

  def self.create_pack(pack, product)
    unless is_pack_ok?(pack, product)
      OpenStruct.new(
        code:     pack[:code],
        quantity: pack[:quantity].to_i,
        price:    pack[:price].to_f)
    end
  end

  def self.is_pack_ok?(pack, product)
    pack[:code] != product[:code] || pack[:quantity].to_i < MIN_QTY_PER_PACK ||
    pack[:code].strip.empty?      || product[:code].strip.empty?
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
