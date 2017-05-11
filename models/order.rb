class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  MESSAGES = {
    empty_cart: "Your cart is empty, please add some items"
  }.freeze

  attr_accessor :material, :items, :discount

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
    return MESSAGES[:empty_cart] if items.count == 0

    [].tap do |result|
      result << "Order for #{material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Total: $#{items_cost}"
      result << if self.discount
        ["Promotions applied: $#{get_discount}",
        "Grand total: $#{total_cost}"]
      end
    end.join("\n")
  end

  def items_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def get_discount
    self.discount ? self.discount.calculate : 0
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
