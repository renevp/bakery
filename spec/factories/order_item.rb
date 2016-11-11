FactoryGirl.define do
  factory :order do
    order_items [OrderItem.new(14,'MB11')]
    initialize_with { order_items }
  end
end
