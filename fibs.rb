# generates, stores and calculates retained fibonacci sequence numbers

class Fibs
  attr_reader :generated_fibs

  def initialize
    @generated_fibs = []
  end

  def generate(x)
    @generated_fibs.any? ? raise(Exception) : @generated_fibs = generate_fibs(x)
  end

  def is_known_fib?(num)
    @generated_fibs.include? num
  end

  def all_fibs?(seq_array)
    @generated_fibs == seq_array
  end

  def known_fibs_sum_of_squares
    if @generated_fibs.any? && @generated_fibs.length > 1
      @generated_fibs.last * generate_fib(pre_previous: @generated_fibs[-2], previous: @generated_fibs[-1])
    else
      0
    end
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

  def generate_fib(index: -1, pre_previous:, previous:)
    return 0 if index == 0
    return 1 if [1, 2].include? index
    pre_previous + previous
  end
end
