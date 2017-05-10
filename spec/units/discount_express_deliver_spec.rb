require './models/discount_express_delivery'
require './models/order'

describe DiscountExpressDelivery do
  let(:order) { Order.new material }
  let(:material) { double(:material, identifier: 'HON/TEST001/010') }

  let(:standard_delivery) { double(:delivery, name: :standard, price: 10) }
  let(:express_delivery) { double(:delivery, name: :express, price: 20) }

  let(:broadcaster_1) { double(:broadcaster, id: 1, name: 'Viacom') }
  let(:broadcaster_2) { double(:broadcaster, id: 2, name: 'Disney') }
  let(:broadcaster_3) { double(:broadcaster, id: 3, name: 'Discovery') }
  let(:broadcaster_4) { double(:broadcaster, id: 4, name: 'Horse and Country') }
  subject { DiscountExpressDelivery.new(order)}

  describe '#calculate' do
    it 'accepts an initial discount value' do
      expect{subject.calculate(5)}.not_to raise_error
    end

    context 'empty order' do
      it 'calculate discount to 0' do
        expect(subject.calculate).to eq(0)
      end
    end

    context 'with items' do
      it 'returns 0 if no conditions apply' do
        order.add broadcaster_1, standard_delivery
        order.add broadcaster_2, express_delivery
        expect(subject.calculate).to eq(0)
      end

      it 'calculates a discount of 5$ on each express_delivery when more than 2 of them are choosen' do
        order.add broadcaster_1, express_delivery
        order.add broadcaster_2, express_delivery
        expect(subject.calculate).to eq(10.0)

        order.add broadcaster_3, express_delivery
        expect(subject.calculate).to eq(15.0)
      end
    end
  end
end
