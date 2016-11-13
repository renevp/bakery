require_relative '../lib/order_line_processing'

describe OrderLineProcessing do

  describe "determine breakdown packs for a order line" do

    context "valid data" do

      it "returns breakdown packs case number 1, packs [3, 5], order total 10" do
        quantity   = 10
        packs      = [3, 5]

        results = process_line(quantity, packs)
        expect(results).to eq([[5, 3], [2]])
      end

      it "returns breakdown packs case number 2, packs [2,5,8], order total 14" do
        quantity   = 14
        packs      = [2,5,8]

        results = process_line(quantity, packs)
        expect(results).to eq([ [8, 5, 2], [0, 2, 2]])
      end

      it "returns breakdown packs case number 3, packs [3, 5, 9], order total 13" do
        quantity   = 13
        packs      = [3, 5, 9]

        results = process_line(quantity, packs)
        expect(results).to eq([[9, 5, 3], [0, 2, 1]])
      end

    end

    context "invalid data" do

      it "returns no solution when no packs" do
        quantity   = 10
        packs      = [0, 0, 0]

        results = process_line(quantity, packs)
        expect(results).to eq("There is not solution for [0, 0, 0] and 10")
      end

      it "it returns no solution when number items is less than the smallest pack" do
        quantity   = 10
        packs      = [20, 30, 40, 11]

        results = process_line(quantity, packs)
        expect(results).to eq("There is not solution for [40, 30, 20, 11] and 10")
      end

      it "it returns no solution when there is not any possible solution" do
        quantity   = 10
        packs      = [20, 15, 9, 4]

        results = process_line(quantity, packs)
        expect(results).to eq("There is not solution for [20, 15, 9, 4] and 10")
      end

    end
  end

  def process_line(quantity, packs)
    line_processing = OrderLineProcessing.new(quantity, packs)
    line_processing.process_order_line
    results = line_processing.results
  end
end
