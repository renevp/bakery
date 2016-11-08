require_relative '../helpers/file_utils'
require 'products'
require 'order'

class Bakery
  def load_products
    products_data = FileUtils.read_csv('./inputs/products.csv')
    packs_data = FileUtils.read_csv('./inputs/packs.csv')
    products = ProductsPacksFactory.build(products_data, packs_data)
  end

  def create_order
    order_data = FileUtils.read_csv('./inputs/order.csv')
    order = OrderFactory.build(order_data)
  end
end
