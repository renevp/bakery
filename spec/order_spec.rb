require_relative '../helpers/file_utils'
require_relative '../lib/order_factory'
require_relative '../lib/order'
require_relative '../lib/order_item'

describe Order do
  let(:order_data) { FileUtils.read_csv('./spec/fixtures/order.csv') }
  let(:order)      { OrderFactory.new(order_data).build() }


  it "includes order items" do
    expect(order).to respond_to(:items)
  end

  it "retrieves all order items" do
    expect(order.items.size).to eq(3)
  end

  it "has order items with quantity and code" do
    expect(order.items[0]).to have_attributes(quantity: 10, code: "VS5")
  end
end
