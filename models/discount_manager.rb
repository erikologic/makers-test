class DiscountManager
  attr_accessor :order, :discounts

  def initialize(order)
    self.order = order
    self.discounts = []
  end

  def add(discount_obj)
    discounts << discount_obj
  end

  def calculate
    discounts.inject(0) do |discount_total, discount_obj|
      discount_total += discount_obj.calculate(discount_total)
    end
  end
end
