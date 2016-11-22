require_relative '../lib/order_line_processing_v2'

describe OrderLineProcessingV2 do

  describe "determine breakdown packs for a order line" do

    context "valid data" do

      it "returns breakdown packs case number 1, packs [3, 5], order total 10" do
        quantity   = 10
        packs      = [3, 5]

        results = process_line(quantity, packs)
        expect(results).to eq([[5, 3], [2, 0]])
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

      it "returns no solution when packs contains 0" do
        quantity   = 10
        packs      = [0, 0, 0]
        expect { process_line(quantity, packs) }.to raise_error(ArgumentError, \
          " Invalid packs, contains '0' '[0, 0, 0]' ")
      end

      it "it returns no solution when number items is less than the smallest pack" do
        quantity   = 10
        packs      = [20, 30, 40, 11]
        expect { process_line(quantity, packs) }.to raise_error(ArgumentError, \
          " Number of items 10 can't be less than min packs '[40, 30, 20, 11]' ")
      end

      it "it returns no solution when there is not any possible solution" do
        quantity   = 10
        packs      = [20, 15, 9, 4]
        expect { process_line(quantity, packs) }.to raise_error(StandardError, \
          " Not solution found for packs '[20, 15, 9, 4]' ")
      end

    end
  end

  def process_line(quantity, packs)
    line_processing = OrderLineProcessingV2.new(quantity, packs)
    line_processing.process_order_line
    results = line_processing.results
  end
end
