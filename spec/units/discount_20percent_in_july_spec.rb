require './models/discount_20percent_in_july'
require './models/order'

describe Discount20PercentInJuly do
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
    context 'when is July but items are less then 30$' do
      it 'returns 0' do
        order.date = Date.new(2017,7,1)
        order.add broadcaster_1, express_delivery
        expect(subject.calculate(order)).to eq(0)

      end
    end
    context 'when we have items with value above 30$ but is not July' do
      it 'returns 0' do
        order.date = Date.new(2017,1,1)

        order.add broadcaster_1, express_delivery
        order.add broadcaster_2, express_delivery
        order.add broadcaster_3, express_delivery

        expect(subject.calculate(order)).to eq(0)
      end
    end
    context 'when we have items with value above 30$ and is July' do
      before do
        order.date = Date.new(2017,7,1)

        order.add broadcaster_1, express_delivery
        order.add broadcaster_2, express_delivery
        order.add broadcaster_3, express_delivery
      end
      it 'calculates a discount with a 20% percent off the total cost' do
        expect(subject.calculate(order)).to eq(12)
      end
      context 'when a discount has been already applied' do
        it 'brings in the calculation the discount applied' do
          expect(subject.calculate(order,6)).to eq(10.8)
        end
      end
    end
  end
end
