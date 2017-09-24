require 'rails_helper'

describe Fib do
  context 'Correct record' do
    it 'create fib' do
      fib = Fib.new
      fib.items = [0, 1, 1, 2]
      expect(fib.save).to eq(true)
    end
  end

  context 'Uncorrect record' do
    it 'cant create fib without items' do
      expect(build(:fib, items: [])).to_not be_valid
    end
  end

  describe '#known_fibs_sum_of_squares' do
    let(:expected_result) { 40 }

    context 'when there are stored numbers' do
      let!(:fib) { create(:fib, items: FibsService.new.generate(6)) }

      it 'returns the sum of the squared values for all known fibs' do
        expect(fib.known_fibs_sum_of_squares).to eq(expected_result)
      end
    end

    context 'when there are no stored numbers' do
      let!(:fib_one_number) { create(:fib, items: FibsService.new.generate(1)) }

      it 'return 0 when length 1' do
        expect(fib_one_number.known_fibs_sum_of_squares).to eq(0)
      end
    end
  end

  describe '#all_fibs?' do
    context 'when passed an array of numbers that are all members of the the fibonacci sequence' do
      let!(:fib) { create(:fib, items: FibsService.new.generate(6)) }

      it 'returns true' do
        expect(fib.items).to eq([0, 1, 1, 2, 3, 5])
      end
    end

    context 'when passed an array of numbers that where at least one is not a member of the sequence' do
      let!(:fib) { create(:fib, items: FibsService.new.generate(6)) }

      it 'returns false' do
        expect(fib.items).to_not eq([0, 1, 2, 3, 4, 5])
      end
    end
  end

  describe '#is_known_fib?' do
    context 'when passed a fibonacci number that it has not stored' do
      let!(:fib) { create(:fib, items: FibsService.new.generate(10)) }

      it 'returns false' do
        expect(fib.items).to_not include(55)
      end
    end

    context 'when passed a number that has been stored' do
      let!(:fib) { create(:fib, items: FibsService.new.generate(10)) }

      it 'returns true' do
        expect(fib.items).to include(34)
      end
    end
  end
end
