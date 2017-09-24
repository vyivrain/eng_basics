FactoryGirl.define do
  factory :fib do
    sequence(:items, 11) { |n| FibsService.new.generate((n..n + 5).to_a.sample) }
  end
end