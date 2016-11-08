require 'csv'
require 'ostruct'

module Utils
  def self.read_csv(csv_file)
    rows = CSV.read csv_file, headers: true, skip_blanks: true, header_converters: :symbol
  end
end

module ProductPacksFactory
  def self.build(products_data, packs_data, product_class = Product)
    products = Array.new
    products_data.each do |product|
      products << product_class.new(product[:name], product[:code],
        (packs_data.collect {|pack| create_pack(pack, product) }).compact)
    end
    products
  end

  def self.create_pack(pack, product)
    if pack[:code] == product[:code]
      OpenStruct.new(
        code:     pack[:code],
        quantity: pack[:quantity],
        price:    pack[:price])
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
end
