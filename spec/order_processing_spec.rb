require_relative '../helpers/file_utils'
require_relative '../lib/order'
require_relative '../lib/order_item'
require_relative '../lib/order_factory'
require_relative '../lib/product'
require_relative '../lib/products'
require_relative '../lib/products_packs_factory'
require_relative '../lib/order_processing'
require_relative '../lib/order_line_processing'


describe OrderProcessing do
  let(:products_data) { FileUtils.read_csv('./spec/fixtures/products.csv') }
  let(:packs_data)    { FileUtils.read_csv('./spec/fixtures/packs.csv') }
  let(:products)      { ProductsPacksFactory.new(products_data, packs_data).build() }
  let(:order_data)    { FileUtils.read_csv('./spec/fixtures/order.csv') }
  let(:order)         { OrderFactory.new(order_data).build() }


  it "determines breakdown packs and subtotal for each line" do
    order_processing = OrderProcessing.new(order, products)
    output_expected = "10 VS5 $17.98\n\t 2 x 5 $8.99\n14 MB11 $53.8\n\t 2 x 5 $16.95\n\t 2 x 2 $9.95\n13 CF $25.85\n\t 2 x 5 $9.95\n\t 1 x 3 $5.95\n"
    expect { order_processing.process() }.to output(output_expected).to_stdout
  end

end
