require './models/discount_abstraction'

class Discount10Percent < DiscountAbstraction
  def calculate(discount_before = 0)
    current_total = order.items_cost - discount_before
    (current_total > 30) ? (current_total * 0.1) : 0
  end
end
