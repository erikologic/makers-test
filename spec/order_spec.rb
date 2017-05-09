require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'

describe Order do
  subject { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }

  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  let(:broadcaster_1) {Broadcaster.new(1, 'Viacom')}
  let(:broadcaster_2) {Broadcaster.new(2, 'Disney')}
  let(:broadcaster_3) {Broadcaster.new(3, 'Discovery')}
  let(:broadcaster_4) {Broadcaster.new(4, 'Horse and Country')}

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

    it 'calculates the total cost applying a 10% off on order above 30$' do
      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, standard_delivery
      subject.add broadcaster_3, standard_delivery
      subject.add broadcaster_4, express_delivery

      expect(subject.total_cost).to eq(45.0)
    end

    it 'calculates the total cost applying a discount of 5$ when more than 2 express_delivery are choosen' do
      subject.add broadcaster_1, express_delivery
      subject.add broadcaster_2, express_delivery
      subject.add broadcaster_3, express_delivery

      expect(subject.total_cost).to eq(40.5)
    end
  end
end
