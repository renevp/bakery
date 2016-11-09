require_relative '../helpers/file_utils'
require_relative '../lib/order'
require_relative '../lib/products'
require_relative '../lib/order_processing'

describe OrderProcessing do
  let(:products_data) { FileUtils.read_csv('./spec/fixtures/products.csv')}
  let(:packs_data) { FileUtils.read_csv('./spec/fixtures/packs.csv')}
  let(:products) { ProductsPacksFactory.build(products_data, packs_data)}

  let(:order_data) { FileUtils.read_csv('./spec/fixtures/order.csv') }
  let(:order) { OrderFactory.build(order_data) }

  it "determines breakdown packs and subtotal for one line" do
    order_processing = OrderProcessing.new(order, products)
    expect { order_processing.make_order() }.to output("10 VS5 $17.98 \n\t 2 x 5 $8.99").to_stdout
  end

  it "calculates total cost"
end
