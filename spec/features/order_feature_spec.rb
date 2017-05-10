require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/discount'
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
    end
  end
end
