class OrderLineProcessingV2
  attr_accessor :num_items, :packs

  def initialize(num_items, packs)
    self.packs     = packs
    self.num_items = num_items
  end

  def num_items=(num_items)
    if packs.min > num_items
      raise ArgumentError.new(" Number of items #{num_items} can't be less than min packs '#{packs}' ")
    end
    @num_items = num_items
  end

  def packs=(packs)
    if packs.include?(0)
      raise ArgumentError.new(" Invalid packs, contains '0' '#{packs}' ")
    end
    @packs = packs.sort.reverse
  end

  def process_order_line
    @pack_quantities = []
    @first_iteration = true
    loop do
      prepare()
      determine_quantities()
      first_iteration?
      solution_not_found?
      break if quantities_ok?
    end
  end

  def results
    [packs, @pack_quantities]
  end

  private

  def prepare
    @results   = []
    if @pack_quantities.count != 0
      tmp_pack_quantities = @pack_quantities
      @pack_quantities    = []
      tmp_pack_quantities.each_index do |index|
        if @current == index && tmp_pack_quantities[index] > 0
          @pack_quantities[index] = tmp_pack_quantities[index] - 1
          @current = index
          break
        else
          @pack_quantities << tmp_pack_quantities[index]
        end
      end
    end
  end

  def determine_quantities
    tmp_num_items = num_items
    packs.each_index do |index|
      if @current == nil || index > @current
        if tmp_num_items < packs[index]
          pack_qty = 0
        else
          pack_qty = tmp_num_items / packs[index]
        end
        @pack_quantities << pack_qty
      else
        pack_qty = @pack_quantities[index]
      end
      @results << packs[index] * pack_qty
      tmp_num_items = tmp_num_items - (packs[index] * pack_qty)
    end
  end

  def first_iteration?
    if @first_iteration
      @current = 0
      @first_iteration = false
    end
  end

  def solution_not_found?
    if @pack_quantities.count > packs.count || @pack_quantities.all? { |e| e == 0 }
      raise StandardError.new(" Not solution found for packs '#{packs}' ")
    end
  end

  def quantities_ok?
    @results.reduce(:+) == num_items
  end
end
