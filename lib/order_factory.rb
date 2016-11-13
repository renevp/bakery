class OrderFactory

  def initialize(order_data, order_class = Order, item_class=OrderItem)
    @order_data  = order_data
    @order_class = order_class
    @item_class  = item_class
  end

  def build
    @order_class.new(create_items())
  end

  private

  def create_items
    (@order_data.collect { |item| create_item(item) } ).compact
  end

  def create_item(item)
    begin
      @item_class.new(item[:quantity], item[:code])
    rescue Exception => e
      p " There was an error creating the item '#{item}' "
      p e.message
      return nil
    end
  end

end
