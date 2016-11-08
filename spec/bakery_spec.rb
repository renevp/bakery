require_relative '../lib/bakery'

describe Bakery do
  it "load products products" do
    bakery = Bakery.new()
    products = bakery.load_products()
    expect(products.size).to equal(3)
  end
  context 'Given a customer order' do
    it 'determines the cost and pack breakdown for each product'
    it 'should contain the minimal number of packs'
  end
end
