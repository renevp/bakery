FactoryGirl.define do
  factory :product do
    code 'MB11'
    name 'Blueberry Muffin'
    packs [2,5,8]

    initialize_with { new(name, code, packs)}
  end
end
