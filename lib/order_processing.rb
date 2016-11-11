class OrderProcessing
  attr_accessor :order, :products, :line_processing_class

  def initialize(order, products, line_processing_class = OrderLineProcessing)
    @order = order
    @products = products
    @line_processing_class = line_processing_class
  end

  def process()
    order.order_items.each do |item|
      qty_list, num_items, pack_list, code = prepare(item)

      line = line_processing_class.new(num_items, qty_list)
      line.process_order_line
      items, quantities = line.results
      line_result       = Hash[items.zip quantities]

      print_output(num_items, code, line_result, pack_list)
    end
  end

  private

  def prepare(item)
    code      = item.code
    pack_list = products.filter(code)[0].packs
    qty_list  = pack_qty_values(pack_list)
    num_items = item.quantity

    return [qty_list, num_items, pack_list, code]
  end

  def pack_qty_values(pack_list)
    pack_list.collect { |pack| pack.quantity }
  end

  def determine_subtotal(line_result, pack_list)
    subtotal = 0
    pack_list.each do |pack|
      line_result.each_pair do |qty, times|
        if pack.quantity == qty && times
          subtotal += pack.price * times
        end
      end
    end
    subtotal.round(2)
  end

  def print_output(num_items, code, line_result, pack_list)
    subtotal = determine_subtotal(line_result, pack_list)
    print "#{num_items} #{code} $#{subtotal}\n"
    line_result.each_pair do |q, times|
      pack_list.each do |pack|
        if pack.quantity == q && times && times != 0
          print "\t #{times} x #{q} $#{pack.price}\n"
        end
      end
    end
  end
end
