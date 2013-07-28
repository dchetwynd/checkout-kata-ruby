require File.expand_path(File.dirname(__FILE__) + '/items_discounter')

class PriceCalculator
  def initialize(item_codes, item_discounter = ItemsDiscounter.new(item_codes))
    @item_codes = item_codes
    @item_discounter = item_discounter
  end

  @@item_prices = {
	  'A' => 50,
	  'B' => 30,
	  'C' => 60,
	  'D' => 15
  }

  def price
    price_before_discount - @item_discounter.discount
  end

  private
  def price_before_discount
    @item_codes.inject(0) do |sum, item_code|
      sum + @@item_prices[item_code]
    end
  end
end
