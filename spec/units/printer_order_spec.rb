require './models/printer_order'
require './models/order'

describe 'Order object features tests' do
  let(:order) { Order.new material }
  let(:material) { double(:material, identifier: 'HON/TEST001/010') }

  let(:standard_delivery) { double(:delivery, name: :standard, price: 10) }
  let(:express_delivery) { double(:delivery, name: :express, price: 20) }

  let(:broadcaster_1) { double(:broadcaster, id: 1, name: 'Viacom') }
  let(:broadcaster_2) { double(:broadcaster, id: 2, name: 'Disney') }
  let(:broadcaster_3) { double(:broadcaster, id: 3, name: 'Disney') }

  subject { PrinterOrder.new(order) }

  describe '#output' do
    context 'empty' do
      it 'prints empty cart message' do
        order.printer = subject
        expect(subject.output).to eq(PrinterOrder::MESSAGES[:empty_cart])
      end
    end
    context 'with items' do
      it 'prints a list of items and total cost' do
        order.printer = subject

        order.add broadcaster_1, standard_delivery
        order.add broadcaster_2, express_delivery

        expectation = %r{.*#{order.material.identifier}.*
          #{order.items[0][0].name}.*
          #{order.items[0][1].name}.*
          #{order.items[0][1].price}.*
          #{order.items[1][0].name}.*
          #{order.items[1][1].name}.*
          #{order.items[1][1].price}.*
          #{order.items_cost}.*
          }xm
        expect(subject.output).to match(expectation)
      end
    end
    context 'with items and applicable discounts' do
      it 'prints a list of items, total discount applied and final cost' do
        order.discount = DiscountExpressDelivery.new(order)

        order.add broadcaster_1, express_delivery
        order.add broadcaster_2, express_delivery
        order.add broadcaster_3, express_delivery

        expectation = %r{.*#{order.material.identifier}.*
          #{order.items[0][0].name}.*
          #{order.items[0][1].name}.*
          #{order.items[0][1].price}.*
          #{order.items[1][0].name}.*
          #{order.items[1][1].name}.*
          #{order.items[1][1].price}.*
          #{order.items_cost}.*
          #{order.get_discount}.*
          #{order.total_cost}.*
          }xm
        expect(subject.output).to match(expectation)
      end
    end
  end
end
