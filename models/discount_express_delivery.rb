class DiscountExpressDelivery
  def calculate(order, discount_before = 0)
    express_delivery_count = order.items.count { |_, delivery| delivery.name == :express }
    (express_delivery_count >= 2) ? (5 * express_delivery_count) : 0
  end
end
