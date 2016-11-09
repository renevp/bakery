class OrderProcessing
  attr_accessor :order, :products

  def initialize(order, products)
    @order = order
    @products = products
  end

  def make_order()
    order.order_items.each do |item|
      quantity_list, number_items, pack_list = prepare(item)
      min_packs = determine_packs(quantity_list, number_items)
      puts min_packs
      puts determine_subtotal(min_packs, pack_list)
    end
  end

  private

  def prepare(item)
    code = item.code
    puts code
    pack_list = products.filter(code)[0].packs
    quantity_list = pack_quantity_values(pack_list)
    number_items = item.quantity
    [quantity_list, number_items, pack_list]
  end

  def determine_packs(quantity_list, number_items)
    puts number_items
    min_packs = Array.new(number_items, 0)
    packs_used = Array.new(number_items, 0)
    (0..number_items).to_a.each do |unit|
      unit_count = unit
      new_unit = 1
      valid_quantities = quantity_list.select { |quantity| quantity <= unit }
      # print valid_quantities
      valid_quantities.each do |q|
        # puts " Q: ", q
        if min_packs[unit - q] + 1 < unit_count
          unit_count = min_packs[ unit - q ] + 1
          new_unit = q
        end
      end
      min_packs[unit] = unit_count
      # print min_packs[unit]
      packs_used[unit] = new_unit
      # print packs_used[unit]
    end
    # print "Min number packs", min_packs[number_items]
    minimal_packs(packs_used, number_items)
  end

  def minimal_packs(packs_used, number_items)
    packs = Hash.new
    unit = number_items
    while unit > 0
      this_unit = packs_used[unit]
      if packs.has_key?(this_unit)
        packs[this_unit] += 1
      else
        packs[this_unit] = 1
      end
      unit = unit - this_unit
    end
    packs
  end

  def determine_subtotal(min_packs, pack_list)
    subtotal = 0
    pack_list.each do |pack|
      min_packs.each_pair do |quantity, times|
        if pack.quantity == quantity
          subtotal += pack.price * times
        end
      end
    end
    subtotal.round(2)
  end

  def pack_quantity_values(pack_list)
    quantity_list = Array.new
    pack_list.each do |pack|
      quantity_list << pack.quantity
    end
    quantity_list
  end
end
