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

  def output(order)
    return empty_cart_msg if order.items.count == 0

    self.order = order
    [].tap do |result|
      result << output_material
      result << output_header
      result << output_separator
      result << output_body
      result << output_separator
      result << output_items_total_and_discount if order.discount
      result << output_grand_total
    end.join("\n")
  end

  private

  def empty_cart_msg
    MESSAGES[:empty_cart]
  end

  def output_material
    "Order for #{order.material.identifier}:"
  end

  def output_header
    COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
  end

  def output_body
    order.items.map do |broadcaster, delivery|
      [
        broadcaster.name.ljust(COLUMNS[:broadcaster]),
        delivery.name.to_s.ljust(COLUMNS[:delivery]),
        ("$#{delivery.price}").ljust(COLUMNS[:price])
      ].join(' | ')
    end
  end

  def output_items_total_and_discount
    [
      output_items_total,
      output_discount,
    ]
  end

  def output_items_total
    "Total: $#{order.items_cost}"
  end

  def output_discount
    "Promotions applied: $#{order.get_discount}"
  end

  def output_grand_total
    "Grand total: $#{order.total_cost}"
  end

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
