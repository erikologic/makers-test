require './models/discount_abstraction'

class DiscountManager < DiscountAbstraction
  attr_accessor :discounts

  def initialize(order)
    super
    self.discounts = []
  end

  def add(discount_obj)
    discounts << discount_obj
  end

  def calculate(discount_before = 0)
    discounts.inject(discount_before) do |discount_total, discount_obj|
      discount_total += discount_obj.calculate(discount_total)
    end
  end
end
