class PrinterOrder
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  MESSAGES = {
    empty_cart: "Your cart is empty, please add some items"
  }.freeze

  attr_accessor :order

  def initialize(order)
    self.order = order
  end

  def output
    return MESSAGES[:empty_cart] if order.items.count == 0

    [].tap do |result|
      result << "Order for #{order.material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      order.items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Total: $#{order.items_cost}"
      result << if order.discount
        ["Promotions applied: $#{order.get_discount}",
        "Grand total: $#{order.total_cost}"]
      end
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
