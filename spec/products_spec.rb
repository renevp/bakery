require_relative "../lib/products"

describe Products do
  let(:products_data) { Utils.read_csv('./spec/fixtures/products.csv')}
  let(:packs_data) { Utils.read_csv('./spec/fixtures/packs.csv')}
  let(:products) { ProductPacksFactory.build(products_data, packs_data)}

  it "retrieves all products" do
    expect(products.size).to equal(3)
  end

  it "includes product packs" do
    expect(products[0]).to respond_to(:packs)
  end

  it "has packs with quantity and price" do
    expect(products[0].packs[0].to_h).to include(:quantity, :price, :code)
  end

  it "filters products by code" do
    filtered = Products.new(products).filter('CF')
    expect(filtered[0].code).to eq('CF')
  end
end
