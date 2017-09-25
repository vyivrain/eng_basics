class FibSerializer < ActiveModel::Serializer
  attributes :id, :items_str, :known_fib_square, :created_at_format

  def created_at_format
    object.created_at.strftime('%d-%m-%y %H:%M')
  end

  def items_str
    object.items.to_s
  end

  def known_fib_square
    object.known_fibs_sum_of_squares
  end
end