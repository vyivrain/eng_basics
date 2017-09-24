require 'rails_helper'

describe FibsService, type: :service do
  subject { FibsService.new }

  describe '#generate' do
    let(:expected_result) { [ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ] }

    it 'returns the number of requested fibonacci numbers' do
      expect(subject.generate(10)).to eq(expected_result)
    end
  end
end
