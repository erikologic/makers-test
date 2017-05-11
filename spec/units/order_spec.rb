require './models/order'

describe Order do
  subject { described_class.new material }
  let(:material) { double(:material, identifier: 'HON/TEST001/010') }

  let(:standard_delivery) { double(:delivery, name: :standard, price: 10) }
  let(:express_delivery) { double(:delivery, name: :express, price: 20) }

  let(:broadcaster_1) { double(:broadcaster, id: 1, name: 'Viacom') }
  let(:broadcaster_2) { double(:broadcaster, id: 2, name: 'Disney') }

  let(:printer) {double(:printer)}

  describe '#output' do
    it 'calls output method on the printer object' do
      subject.printer = printer
      allow(printer).to receive(:output)
      subject.output
      expect(printer).to have_received(:output)
    end
  end
  describe '#total_cost' do
    context 'empty' do
      it 'costs nothing' do
        expect(subject.total_cost).to eq(0)
      end
    end

    context 'with items' do
      before do
        subject.add broadcaster_1, standard_delivery
        subject.add broadcaster_2, express_delivery
      end

      it 'returns the total cost of all items' do
        expect(subject.total_cost).to eq(30)
      end

      it 'calls calculate method of discount object, applying discount to the order' do
        discount = double(:discount, calculate: 5)
        subject.discount = discount

        expect(subject.total_cost).to eq(25)
        expect(discount).to have_received(:calculate)
      end
    end
  end
end
