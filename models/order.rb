class Order
  attr_accessor :material, :items, :discount, :printer

  def initialize(material)
    self.material = material
    self.items = []
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def total_cost
    items_cost - get_discount
  end

  def output
    self.printer.output
  end

  def items_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def get_discount
    self.discount ? self.discount.calculate : 0
  end
end
