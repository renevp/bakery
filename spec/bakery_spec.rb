require_relative '../lib/bakery'

describe Bakery do
  it "load product's packs" do
    bakery = Bakery.new()
    packs = bakery.load_packs()
    expect(packs.size).to equal(3)
  end
  context 'Given a customer order' do
    it 'determines the cost and pack breakdown for each product'
    it 'should contain the minimal number of packs'
  end
end
