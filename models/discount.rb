class Discount
  attr_accessor :order
  def initialize(order)
    self.order = order
  end

  def calculate
    order = self.order
    discount = 0.0

    express_count = order.items.count { |_, delivery| delivery.name == :express }
    discount += 5 * express_count if express_count >= 2

    discount += (order.items_cost.to_f - discount) / 100 * 10 if (order.items_cost.to_f - discount) > 30

    discount
  end
end
