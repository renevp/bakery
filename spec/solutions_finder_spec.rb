require_relative '../lib/solution_finder'
require_relative '../lib/order_line_processing'
require_relative '../lib/order_line_processing_v2'

describe SolutionsFinder do

  context 'Given a number of items and list of packs' do
    describe 'Determine all posible solutions' do
      it 'finds solutions for packs [2,5,8] and number of items 14' do
        quantity = 15
        packs = [2,5,8]
        finder = SolutionsFinder.new(quantity, packs)
        finder.process_order_line
        solutions = finder.results
        expect(solutions). to eq([[[5], [5, 2]], [[3], [1, 1, 1]]])
      end
    end
  end

end
