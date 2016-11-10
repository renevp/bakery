require_relative '../lib/order'
require_relative '../helpers/file_utils'

describe Order do
  let(:order_data) { FileUtils.read_csv('./spec/fixtures/order.csv') }
  let(:order) { OrderFactory.build(order_data) }

  it "includes order items" do
    expect(order).to respond_to(:order_items)
  end

  it "retrieves all order items" do
    expect(order.order_items.size).to eq(3)
  end

  it "has order lines with quantity and code" do
    expect(order.order_items[0].to_h).to include(:quantity, :code)
  end
end
