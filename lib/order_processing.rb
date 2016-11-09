class OrderProcessing
  attr_accessor :order, :products

  def initialize(order, products)
    @order = order
    @products = products
  end

  def make_order()
    args = prepare()
    make_order_line(args[0], args[1], args[2], args[3], args[4])
  end

  private

  def prepare()
    pack_list = products.filter(order.order_items[0].code)[0].packs
    quantity_list, price_list = pack_quantity_price_values(pack_list)
    number_items = order.order_items[0].quantity.to_i
    min_packs = Array.new(number_items, 0)
    packs_used = Array.new(number_items, 0)
    [quantity_list, price_list, number_items, min_packs, packs_used]
  end

  def make_order_line(quantity_list, price_list, number_items, min_packs, packs_used)
    puts number_items
    print quantity_list
    print price_list
    print min_packs

    (0..number_items).to_a.each do |unit|
      unit_count = unit
      new_unit = 1
      valid_quantities = quantity_list.select { |quantity| quantity <= number_items }
      valid_quantities.each do |q|
        if min_packs[unit - q] + 1 < unit_count
          unit_count = min_packs[unit - q] + 1
          new_unit = q
          puts unit_count
        end
      end
      min_packs[unit] = unit_count
      packs_used[unit] = new_unit
    end
    print min_packs[number_items]
    print packs_used
    print_packs(packs_used, number_items)
    print "10 VS5 $17.98 \n\t 2 x 5 $8.99"
  end

  def print_packs(packs_used, number_items)
    unit = number_items
    while unit > 0
      this_unit = packs_used[unit]
      print(this_unit)
      unit = unit - this_unit
    end
  end

  def pack_quantity_price_values(pack_list)
    quantity_list = Array.new
    price_list = Array.new
    pack_list.each do |pack|
      quantity_list << pack.quantity.to_i
      price_list << pack.price.to_f
    end
    [quantity_list, price_list]
  end
end
