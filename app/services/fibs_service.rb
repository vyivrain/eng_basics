class FibsService
  attr_reader :generated_fibs

  def initialize
    @generated_fibs = []
  end

  def generate(x)
    generate_fibs(x)
  end

  def self.generate_fib(pre_previous:, previous:)
    new.generate_fib(pre_previous: pre_previous, previous: previous)
  end

  def generate_fib(index: -1, pre_previous:, previous:)
    return 0 if index == 0
    return 1 if [1, 2].include? index
    pre_previous + previous
  end

  private

  def generate_fibs(x)
    pre_previous_fib = 0
    previous_fib = 0
    (0...x).map do |i|
      temp = generate_fib(index: i, pre_previous: pre_previous_fib, previous: previous_fib)
      pre_previous_fib = previous_fib
      previous_fib = temp
      temp
    end
  end
end