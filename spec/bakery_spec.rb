require_relative '../lib/bakery'

describe Bakery do
  let(:bakery) { Bakery.new()}

  context "Given a customer order" do
    it 'determines the cost and pack breakdown for each product'
    it 'should contain the minimal number of packs'
  end
end
