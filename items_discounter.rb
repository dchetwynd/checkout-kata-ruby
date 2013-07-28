class ItemsDiscounter
  def initialize(items)
    @original_items = items
  end

  def discount
    total_discount = 0
    copied_items = @original_items.dup
    while remaining_discounts?(copied_items)
      if has_three_a_items?(copied_items)
	remove_item_from_list(copied_items, 'A', 3)
        total_discount += 20
      elsif has_two_b_items?(copied_items)
	remove_item_from_list(copied_items, 'B', 2)
        total_discount += 15
      end
    end
    total_discount
  end

  private

  def remove_item_from_list(list, item, number_of_items_to_remove)
    number_of_items_to_remove.times do
      list.delete_at(list.index(item))
    end
  end

  def remaining_discounts?(items)
    has_three_a_items?(items) or has_two_b_items?(items)
  end

  def has_three_a_items?(items)
   a_items = items.select {|item| item == 'A'}
   a_items.size >= 3
  end

  def has_two_b_items?(items)
    b_items = items.select {|item| item == 'B'}
    b_items.size >= 2
  end
end
