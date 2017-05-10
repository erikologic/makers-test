require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/discount'
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

      it 'apply the correct discounts to the order' do
        subject.discount = Discount.new(subject)

        subject.add broadcaster_1, express_delivery
        subject.add broadcaster_2, express_delivery
        subject.add broadcaster_3, express_delivery

        expect(subject.total_cost).to eq(40.5)
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
end
