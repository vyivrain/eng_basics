require_relative '../fibs'

describe Fibs do
  subject { Fibs.new }

  describe '#generate' do
    let(:expected_result) { [ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ] }

    it 'returns the number of requested fibonacci numbers' do
      expect(subject.generate(10) ).to eq(expected_result)
    end

    it 'stores the values' do
      subject.generate(10)
      expect(subject.generated_fibs).to eq(expected_result)
    end

    context 'when it already knows the requested number of sequence numbers' do
      before do
        subject.generate(5)
      end

      it 'does not call generate_fibs' do
        expect{subject.generate(5)}.to raise_error(Exception)
      end
    end
  end

  describe '#is_known_fib?' do
    context 'when passed a fibonacci number that it has not stored' do
      it 'returns false' do
        subject.generate(10)
        expect(subject.generated_fibs).to_not include(55)
      end
    end

    context 'when passed a number that has been stored' do
      it 'returns true' do
        subject.generate(10)
        expect(subject.generated_fibs).to include(34)
      end
    end
  end

  describe '#all_fibs?' do
    context 'when passed an array of numbers that are all members of the the fibonacci sequence' do
      it 'returns true' do
        subject.generate(6)
        expect(subject.generated_fibs).to eq([0, 1, 1, 2, 3, 5])
      end
    end

    context 'when passed an array of numbers that where at least one is not a member of the sequence' do
      it 'returns false' do
        subject.generate(6)
        expect(subject.generated_fibs).to_not eq([0, 1, 2, 3, 4, 5])
      end
    end
  end

  describe '#known_fibs_sum_of_squares' do
    let(:expected_result) { 40 }

    context 'when there are stored numbers' do
      before { subject.generate(6) }

      it 'returns the sum of the squared values for all known fibs' do
        expect(subject.known_fibs_sum_of_squares).to eq(expected_result)
      end
    end

    context 'when there are no stored numbers' do
      it 'returns 0' do
        expect(subject.known_fibs_sum_of_squares).to eq(0)
      end

      it 'return 0 when length 1' do
        subject.generate(1)
        expect(subject.known_fibs_sum_of_squares).to eq(0)
      end
    end
  end
end
