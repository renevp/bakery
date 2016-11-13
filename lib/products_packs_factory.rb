require 'ostruct'

class ProductsPacksFactory
  MIN_QTY_PER_PACK = 1

  def initialize(products_data, packs_data, product_class=Product, products_class=Products)
    @products_data  = products_data
    @packs_data     = packs_data
    @product_class  = product_class
    @products_class = products_class
  end

  def build
    products = @products_data.collect do |product|
      create_product(product)
    end
    @products_class.new(products) if products.count > 0
  end

  private

  def create_product(product)
    @product_class.new(product[:name], product[:code], add_packs_to_product(product, @packs_data)) unless product[:code].strip.empty?
  end

  def add_packs_to_product(product, packs_data)
    (packs_data.collect { |pack| create_pack(pack, product[:code]) }).compact
  end

  def create_pack(pack, product_code)
    unless is_pack_error?(pack, product_code)
      OpenStruct.new(
        code:     pack[:code],
        quantity: pack[:quantity].to_i,
        price:    pack[:price].to_f)
    end
  end

  def is_pack_error?(pack, product_code)
    pack[:code] != product_code || pack[:quantity].to_i < MIN_QTY_PER_PACK || pack[:code].strip.empty?
  end
end
