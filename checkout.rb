require File.expand_path(File.dirname(__FILE__) + '/price_calculator.rb')

class Checkout
  def initialize
    @shopping_basket = []
  end

  def scan(item_code)
    @shopping_basket << item_code
  end

  def total
    PriceCalculator.new(@shopping_basket).price
  end
end
