class Discount20PercentInJuly
  def calculate(order, discount_before = 0)
    return 0 unless order.date.mon == 7

    current_total = order.items_cost - discount_before
    (current_total > 30) ? (current_total * 0.2) : 0
  end
end
