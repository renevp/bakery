require_relative '../lib/order'
require_relative '../lib/order_item'
require_relative '../lib/product'
require_relative '../lib/order_line_processing'

describe OrderLineProcessing do
  let(:product) { FactoryGirl.build(:product) }
  let(:items_valid) { FactoryGirl.build(:order) }
  let(:invalid) { [OrderItem.new(1,'MB11')] }
  let(:items_invalid) { FactoryGirl.attributes_for(:order, items: invalid) }

  it "rejects order lines with number of items less than minimum quantity packs" do
   quantity = items_invalid[:items][0].quantity
   results = process_line(quantity, product.packs)
   expect(results).to eq([ [8, 5, 2], []])
  end

  it "determines breakdown packs and subtotal for one line" do
    quantity = items_valid[0].quantity
    results = process_line(quantity, product.packs)
    expect(results).to eq([ [8, 5, 2], [0, 2, 2]])
  end

  describe "a different case" do
    let(:product) { FactoryGirl.attributes_for(:product, packs: [23, 15, 4, 3]) }
    let(:items) { [OrderItem.new(11,'MB11')] }
    let(:order) { FactoryGirl.attributes_for(:order, items: items) }

    it "determines breakdown packs and subtotal for one line" do
      quantity = order[:items][0].quantity
      results = process_line(quantity, product[:packs])
      expect(results).to eq([[23, 15, 4, 3], [0, 0, 2, 1]])
    end
  end

  def process_line(quantity, packs)
    line_processing = OrderLineProcessing.new(quantity, packs)
    line_processing.process_order_line
    results = line_processing.results
  end
end
