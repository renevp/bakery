require 'products'

class Bakery

  def load_products
    products_data = Utils.read_csv('./spec/fixtures/products.csv')
    packs_data = Utils.read_csv('./spec/fixtures/packs.csv')
    products = ProductPacksFactory.build(products_data, packs_data)
    Products.new(products)
  end

end
