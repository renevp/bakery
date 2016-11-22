class OrderProcessingAllSolutions < OrderProcessing

  def process
    order.items.each do |item|
      begin
        prepare(item)
        results = process_item()
        results.each_pair do |qtties, t|
          @result = Hash[qtties.zip t]
          print_output()
        end
      rescue => e
        p " There was an error processing the item '#{item}' "
        p e.message
      end
    end
  end

end
