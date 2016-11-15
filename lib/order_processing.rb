class OrderProcessing
  NUMBER_OF_DECIMALS = 2

  attr_accessor :order, :products, :line_processing_class

  def initialize(order, products, line_processing_class = OrderLineProcessing)
    @order = order
    @products = products
    @line_processing_class = line_processing_class
  end

  def process
    order.items.each do |item|
      begin
        prepare(item)
        @result = process_item()
        print_output()
      rescue Exception => e
        p " There was an error processing the item '#{item}' "
        p e.message
      end
    end
  end

  private

  def prepare(item)
    @code      = item.code
    find_packs()
    @qty_list  = pack_qty_values()
    @num_items = item.quantity
    is_num_items_ok?()
  end

  def find_packs
    begin
      @pack_list = products.filter(@code)[0].packs
    rescue
      raise ArgumentError.new(" Product code can't be found: '#{@code}' ")
    end
  end

  def is_num_items_ok?
    if @qty_list.min > @num_items
      raise ArgumentError.new(" Number of items can't be less than the smallest pack ")
    end
  end

  def process_item
    line                     = line_processing_class.new(@num_items, @qty_list)
    line.process_order_line
    items, quantities        = line.results
    return Hash[items.zip quantities]
  end

  def pack_qty_values
    @pack_list.collect { |pack| pack.quantity }
  end

  def determine_subtotal
    subtotal = 0
    @pack_list.each do |pack|
        @result.each_pair do |qty, times|
        if pack.quantity == qty && times
          subtotal += pack.price * times
        end
      end
    end
    subtotal.round(NUMBER_OF_DECIMALS)
  end

  def print_output
    subtotal = determine_subtotal()
    print "#{@num_items} #{@code} $#{subtotal}\n"
    @result.each_pair do |quantity, times|
      print_breakdown(quantity, times)
    end
  end

  def print_breakdown(quantity, times)
    @pack_list.each do |pack|
      if pack.quantity == quantity && times && times != 0
        print "\t #{times} x #{quantity} $#{pack.price}\n"
      end
    end
  end

end
