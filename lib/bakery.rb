require_relative '../helpers/file_utils'
require_relative 'products'
require_relative 'order'
require_relative 'order_processing'
require_relative 'products_packs_factory'
require_relative 'product'
require_relative 'order_factory'
require_relative 'order_item'
require_relative 'order_line_processing'

class Bakery
  attr_accessor :order_processing_class

  def initialize(order_processing_class=OrderProcessing)
    @order_processing_class = order_processing_class
  end

  def load_products
    products_data = FileUtils.read_csv('./inputs/products.csv')
    packs_data    = FileUtils.read_csv('./inputs/packs.csv')
    products      = ProductsPacksFactory.new(products_data, packs_data).build()
  end

  def get_order
    order_data = FileUtils.read_csv('./inputs/order.csv')
    order      = OrderFactory.new(order_data).build()
  end

  def main
    products         = load_products()
    order            = get_order()
    order_processing = order_processing_class.new(order, products)
    order_processing.process()
  end
end

bakery = Bakery.new()
bakery.main()
