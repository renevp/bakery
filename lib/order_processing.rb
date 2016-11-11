class OrderProcessing
  attr_accessor :order, :products, :line_processing_class

  def initialize(order, products, line_processing_class = OrderLineProcessing)
    @order = order
    @products = products
    @line_processing_class = line_processing_class
  end

  def process
    order.items.each do |item|
      prepare(item)
      @result = process_item
      print_output
    end
  end

  private

  def process_item
    line                     = line_processing_class.new(@num_items, @qty_list)
    line.process_order_line
    items, quantities        = line.results
    return Hash[items.zip quantities]
  end

  def prepare(item)
    @code      = item.code
    @pack_list = products.filter(@code)[0].packs
    @qty_list  = pack_qty_values
    @num_items = item.quantity
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
    subtotal.round(2)
  end

  def print_output
    subtotal = determine_subtotal
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
