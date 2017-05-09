class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items

  def initialize(material)
    self.material = material
    self.items = []
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def total_cost
    items_cost - get_discounts
  end

  def output
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
      result << "Total: $#{total_cost}"
    end.join("\n")
  end

  private

  def items_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def get_discounts
    discount = 0.0

    express_count = items.count { |_, delivery| delivery.name == :express }
    discount += 5 * express_count if express_count >= 2

    discount += (items_cost.to_f - discount) / 100 * 10 if items_cost > 30

    discount
  end

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
