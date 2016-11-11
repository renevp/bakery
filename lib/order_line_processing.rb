class OrderLineProcessing

  attr_accessor :max_items, :items

  def initialize(max_items, items)
    @max_items = max_items
    @items     = items.sort.reverse
  end

  def process_order_line
    @quantities = []
    @results    = []
    return "invalid input" unless is_items_ok?
    @remaining  = max_items
    current     = 0

    loop do
      if current >= items.count
      #  p "--------NEXT ITERATION---------"
        current = next_iteration()
        return "invalid input" if !current
      end
      if @remaining >= items[current]
         @quantities[current] = calculate_quantity(current)
         @remaining          -= calculate_results(current)
      else
         @quantities[current] = 0
      end
      @results[current] = calculate_results(current)
      # p "--------#{current}---------"
      # p items
      # p @quantities
      # p @results
      current += 1
      break if first_result_founded?
    end
  end

  def results
    p items
    p @quantities
    p @results
    return [items, @quantities]
  end

  private

  def next_iteration
    @remaining = max_items
    flag       = true
    current    = 0
    i          = 0
    while( i <= items.count && flag == true )
      if  @quantities[i] > 0
        @quantities[i] -= 1
        @remaining     -= calculate_results(i)
        current         = i + 1
        flag            = false
      end
      @results[i] = calculate_results(i)
      i += 1
      return false if i >= items.count
    end
    current
  end

  def total
    @results.reduce(:+)
  end

  def first_result_founded?
     total == max_items
  end

  def calculate_results(current)
    @quantities[current] * items[current]
  end

  def calculate_quantity(current)
    @remaining / items[current]
  end

  def is_items_ok?
   max_items >= items.min
  end


end