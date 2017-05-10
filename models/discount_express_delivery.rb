class DiscountExpressDelivery
  attr_accessor :order

  def initialize(order)
    self.order = order
  end

  def calculate(discount_before = 0)
    express_delivery_count = self.order.items.count { |_, delivery| delivery.name == :express }
    (express_delivery_count >= 2) ? (5 * express_delivery_count) : 0
  end
end
