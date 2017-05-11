require './models/discount_10percent'
require './models/order'

describe Discount10Percent do
  let(:order) { Order.new material }
  let(:material) { double(:material, identifier: 'HON/TEST001/010') }

  let(:standard_delivery) { double(:delivery, name: :standard, price: 10) }
  let(:express_delivery) { double(:delivery, name: :express, price: 20) }

  let(:broadcaster_1) { double(:broadcaster, id: 1, name: 'Viacom') }
  let(:broadcaster_2) { double(:broadcaster, id: 2, name: 'Disney') }
  let(:broadcaster_3) { double(:broadcaster, id: 3, name: 'Discovery') }
  let(:broadcaster_4) { double(:broadcaster, id: 4, name: 'Horse and Country') }
  subject { described_class.new}

  describe '#calculate' do
    it 'accepts an initial discount value' do
      expect{subject.calculate(order, 5)}.not_to raise_error
    end

    context 'empty order' do
      it 'calculate discount to 0' do
        expect(subject.calculate(order)).to eq(0)
      end
    end

    context 'with items' do
      it 'returns 0 if no conditions apply' do
        order.add broadcaster_1, standard_delivery
        order.add broadcaster_2, express_delivery
        expect(subject.calculate(order)).to eq(0)
      end

      it 'calculates a 10% off on order above 30$' do
        order.add broadcaster_1, standard_delivery
        order.add broadcaster_2, standard_delivery
        order.add broadcaster_3, standard_delivery
        order.add broadcaster_4, express_delivery

        expect(subject.calculate(order)).to eq(5.0)
      end

      it 'discount has to be applied on discounted total' do
        order.add broadcaster_1, express_delivery
        order.add broadcaster_2, express_delivery
        order.add broadcaster_3, express_delivery

        expect(subject.calculate(order, 15)).to eq(4.5)
      end
    end
  end
end
