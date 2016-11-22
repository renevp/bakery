class SolutionsFinder

  attr_accessor :quantity, :packs, :solutions

  def initialize(quantity, packs, line_processing_class=OrderLineProcessing)
    @quantity        = quantity
    self.packs       = packs
    @line_processing = line_processing_class
    @solutions       = []
    @combinations    = []
  end

  def packs=(packs)
    if packs.include?(0)
      raise ArgumentError.new(" Invalid packs, contains '0' '#{packs}' ")
    end
    @packs = packs.sort.reverse
  end

  def process_order_line
    combinations()
    @valid_combinations = []
    @combinations.each do |packs|
      begin
        line = @line_processing.new(@quantity, packs)
        line.process_order_line()
        results = line.results()[1]
        if results.is_a?(Array)
          @solutions << results
          @valid_combinations << packs
        end
      rescue => e
        p "No solution for packs #{packs}"
      end
    end
    remove_dups()
  end

  def remove_dups
    @valid_solutions = []
    @solutions.each_index do |index|
      if @solutions[index].include?(0) || @valid_solutions.count(@solutions[index]) > 0
        @valid_combinations.delete_at(index)
      else
        @valid_solutions << @solutions[index]
      end
    end
  end

  def results
    [@valid_combinations, @valid_solutions]
  end

  def combinations
    count = 1
    loop do
      @combinations.concat(@packs.combination(count).to_a)
      count += 1
      break if count > @packs.count
    end
  end

end
