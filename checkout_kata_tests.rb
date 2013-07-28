require 'rspec'
require File.expand_path(File.dirname(__FILE__) + '/price_calculator')
require File.expand_path(File.dirname(__FILE__) + '/items_discounter')
require File.expand_path(File.dirname(__FILE__) + '/checkout.rb')

describe "Checkout" do
  it 'should give a price of 130 for three A items' do
    checkout = Checkout.new
    checkout.scan('A')
    checkout.scan('A')
    checkout.scan('A')
    checkout.total.should == 130
  end

  it 'should give a price of 45 for two B items' do
    checkout = Checkout.new
    checkout.scan('B')
    checkout.scan('B')
    checkout.total.should == 45
  end
end

describe "Price calculator" do
  it 'should return a price of 0 for an empty basket' do
    shopping_basket = []
    PriceCalculator.new(shopping_basket).price.should == 0
  end

  it 'should return a price of 50 for a basket containing one A item' do
    shopping_basket = ['A']
    PriceCalculator.new(shopping_basket).price.should == 50
  end

  it 'should return a price of 30 for a basket containing one B item' do
    shopping_basket = ['B']
    PriceCalculator.new(shopping_basket).price.should == 30
  end

  it 'should return a price of 60 for a basket containing one C item' do
    shopping_basket = ['C']
    PriceCalculator.new(shopping_basket).price.should == 60
  end

  it 'should return a price of 15 for a basket containing one D item' do
    shopping_basket = ['D']
    PriceCalculator.new(shopping_basket).price.should == 15
  end

  it 'should return a price of 100 for a basket containing two A items' do
    shopping_basket = ['A', 'A']
    PriceCalculator.new(shopping_basket).price.should == 100
  end

  it 'should return a price of 80 for a basket containing one A item and one B item' do
    shopping_basket = ['A', 'B']
    PriceCalculator.new(shopping_basket).price.should == 80
  end

  it 'should return the discount calculated by the item discounter' do
    shopping_basket = ['A', 'B', 'C', 'D']
    items_discounter = double('ItemsDiscounter')
    items_discounter.stub(:discount).and_return(75)

    PriceCalculator.new(shopping_basket, items_discounter).price.should == 80
  end
end

describe 'Item discounter' do
  it 'should not return any discount for two A items' do
    ItemsDiscounter.new(['A', 'A']).discount.should == 0
  end

  it 'should return a discount of 20 for three A items' do
    ItemsDiscounter.new(['A', 'A', 'A']).discount.should == 20
  end

  it 'should not return a discount for one B item' do
    ItemsDiscounter.new(['B']).discount.should == 0
  end

  it 'should return a discount of 15 for two B items' do
    ItemsDiscounter.new(['B', 'B']).discount.should == 15 
  end

  it 'should return a discount of 20 for three A items and one B item' do
    ItemsDiscounter.new(['A', 'A', 'A', 'B']).discount.should == 20
  end

  it 'should return a discount of 15 for two B items and one A item' do
    ItemsDiscounter.new(['B', 'B', 'A']).discount.should == 15
  end

  it 'should return a discount of 40 for six A items' do
    ItemsDiscounter.new(['A', 'A', 'A', 'A', 'A', 'A']).discount.should == 40
  end
end
