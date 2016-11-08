require_relative '../lib/products'
require_relative '../helpers/file_utils'

describe Products do
  let(:products_data) { FileUtils.read_csv('./spec/fixtures/products.csv')}
  let(:packs_data) { FileUtils.read_csv('./spec/fixtures/packs.csv')}
  let(:object) { ProductsPacksFactory.build(products_data, packs_data)}

  it "retrieves all products" do
    expect(object.products.size).to eq(3)
  end

  it "includes product packs" do
    expect(object.products[0]).to respond_to(:packs)
  end

  it "has packs with quantity and price" do
    expect(object.products[0].packs[0].to_h).to include(:quantity, :price, :code)
  end

  it "filters products by code" do
    filtered = object.filter('CF')
    expect(filtered[0].code).to eq('CF')
  end
end
