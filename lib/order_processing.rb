class OrderProcessing
  attr_accessor :order, :products, :line_processing

  def initialize(order, products, line_processing_class = OrderLineProcessing)
    @order = order
    @products = products
    @line_processing = line_processing_class
  end

  def make_order()
    order.order_items.each do |item|
      qty_list, num_items, pack_list = prepare(item)
      p num_items
      lp = line_processing.new(num_items, qty_list)
      lp.process_order_line
      items, quantities = lp.results
      p items
      p quantities
      p determine_subtotal(items, quantities, pack_list)
    end
  end

  private

  def prepare(item)
    code = item.code
    p code
    pack_list = products.filter(code)[0].packs
    qty_list = pack_qty_values(pack_list)
    num_items = item.quantity
    [qty_list, num_items, pack_list]
  end

  def determine_subtotal(items, quantities, pack_list)
    subtotal = 0
    h = Hash[items.zip quantities]
    p h
    pack_list.each do |pack|
      h.each_pair do |qty, times|
        if pack.quantity == qty && times
          subtotal += pack.price * times
        end
      end
    end
    subtotal.round(2)
  end

  def pack_qty_values(pack_list)
    pack_list.collect { |pack| pack.quantity }
  end
end
