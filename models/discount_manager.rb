class DiscountManager
  attr_accessor :discounts

  def initialize
    self.discounts = []
  end

  def add(discount_obj)
    discounts << discount_obj
  end

  def calculate(order, discount_before = 0)
    discounts.inject(discount_before) do |discount_total, discount_obj|
      discount_total += discount_obj.calculate(order, discount_total)
    end
  end
end
