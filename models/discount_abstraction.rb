class DiscountAbstraction
  attr_accessor :order

  def initialize(order)
    self.order = order
  end

  def calculate(args = nil)
    raise NotImplementedError
  end
end
