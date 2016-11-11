require 'ostruct'

module ProductsPacksFactory
  MIN_QTY_PER_PACK = 1

  def self.build(products_data, packs_data, product_class=Product, products_class=Products)
    products = products_data.collect do |product|
      create_product(packs_data, product, product_class)
    end
    products_class.new(products) if products.count > 0
  end

  private

  def self.create_product(packs_data, product, product_class)
    product_class.new(product[:name], product[:code], create_packs(packs_data, product))
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
