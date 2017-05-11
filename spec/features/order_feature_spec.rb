require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/discount_manager'
require './models/discount_express_delivery'
require './models/discount_10percent'
require './models/order'

describe 'Order object features tests' do
  subject { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }

  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  let(:broadcaster_1) {Broadcaster.new(1, 'Viacom')}
  let(:broadcaster_2) {Broadcaster.new(2, 'Disney')}
  let(:broadcaster_3) {Broadcaster.new(3, 'Discovery')}
  let(:broadcaster_4) {Broadcaster.new(4, 'Horse and Country')}

  describe '#total_cost' do
    context 'empty' do
      it 'costs nothing' do
        expect(subject.total_cost).to eq(0)
      end
    end
    context 'with items' do
      it 'returns the total cost of all items' do
        subject.add broadcaster_1, standard_delivery
        subject.add broadcaster_2, express_delivery

        expect(subject.total_cost).to eq(30)
      end

      it 'can use discount_express_delivery objects' do
        subject.discount = DiscountExpressDelivery.new(subject)

        subject.add broadcaster_1, express_delivery
        subject.add broadcaster_2, express_delivery
        subject.add broadcaster_3, express_delivery

        expect(subject.total_cost).to eq(45)
      end

      it 'can use discount_10percent objects' do
        subject.discount = Discount10Percent.new(subject)

        subject.add broadcaster_1, express_delivery
        subject.add broadcaster_2, express_delivery
        subject.add broadcaster_3, express_delivery

        expect(subject.total_cost).to eq(54)
      end

      it 'can use discount_manager objects' do
        discount_manager = DiscountManager.new(subject)
        discount_manager.add DiscountExpressDelivery.new(subject)
        discount_manager.add Discount10Percent.new(subject)

        subject.discount = discount_manager

        subject.add broadcaster_1, express_delivery
        subject.add broadcaster_2, express_delivery
        subject.add broadcaster_3, express_delivery

        expect(subject.total_cost).to eq(40.5)
      end
    end
  end

  describe '#output' do
    context 'empty' do
      it 'prints empty cart message' do
        expect(subject.output).to eq(Order::MESSAGES[:empty_cart])
      end
    end
    context 'with items' do
      it 'prints a list of items and total cost' do
        subject.add broadcaster_1, standard_delivery
        subject.add broadcaster_2, express_delivery

        expectation = %r{.*#{subject.material.identifier}.*
          #{subject.items[0][0].name}.*
          #{subject.items[0][1].name}.*
          #{subject.items[0][1].price}.*
          #{subject.items[1][0].name}.*
          #{subject.items[1][1].name}.*
          #{subject.items[1][1].price}.*
          #{subject.items_cost}.*
          }xm
        expect(subject.output).to match(expectation)
      end
    end
    context 'with items and applicable discounts' do
      it 'prints a list of items, total discount applied and final cost' do
        subject.discount = DiscountExpressDelivery.new(subject)

        subject.add broadcaster_1, express_delivery
        subject.add broadcaster_2, express_delivery
        subject.add broadcaster_3, express_delivery

        expectation = %r{.*#{subject.material.identifier}.*
          #{subject.items[0][0].name}.*
          #{subject.items[0][1].name}.*
          #{subject.items[0][1].price}.*
          #{subject.items[1][0].name}.*
          #{subject.items[1][1].name}.*
          #{subject.items[1][1].price}.*
          #{subject.items_cost}.*
          #{subject.get_discount}.*
          #{subject.total_cost}.*
          }xm
        expect(subject.output).to match(expectation)
      end
    end
  end
end
