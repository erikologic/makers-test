require './models/discount_manager'

describe DiscountManager do
  let(:order) { double(:order) }
  subject { described_class.new(order)}

  let(:discount_obj1) { double(:discount_obj, calculate: 5)}

  describe '#calculate' do
    context 'with no object registered' do
      it 'returns 0' do
        expect(subject.calculate).to eq(0)
      end
    end

    context 'with discount objects registered'do
      it 'calls calculate on each registered discount object ' do
        subject.add discount_obj1
        expect(subject.calculate).to eq(5)
        expect(discount_obj1).to have_received(:calculate).once
      end

      it 'will pass the calculated discount on each iteration' do
        discount_obj2 = double(:discount_obj2)
        allow(discount_obj2).to receive(:calculate) do |discount|
          discount * 2
        end

        subject.add discount_obj1
        subject.add discount_obj2

        expect(subject.calculate).to eq(15)
      end
    end
  end
end
