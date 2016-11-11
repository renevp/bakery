FactoryGirl.define do
  factory :order do
    items [OrderItem.new(14,'MB11')]
    
    initialize_with { items }
  end
end
