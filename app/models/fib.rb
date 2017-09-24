class Fib < ApplicationRecord
  validates :items, presence: true, uniqueness: true

  def is_known_fib?(num)
    return false unless num.present?
    items.include? num.to_i
  end

  def all_fibs?(seq_array)
    return false unless seq_array.present?
    items == seq_array.split(',').map(&:to_i)
  end

  def known_fibs_sum_of_squares
    if items.any? && items.length > 1
      items.last * FibsService.generate_fib(pre_previous: items[-2], previous: items[-1])
    else
      0
    end
  end
end
