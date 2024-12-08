calibrations = File.readlines("example.txt", chomp: true).inject({}) do |hash, calibration|
  test_value, numbers = calibration.split(': ')
  hash[test_value.to_i] = numbers.split.map(&:to_i)
  hash
end

operators = [:+, :*].freeze

results = calibrations.map do |test_value, numbers|
  operation_sequences = operators.repeated_permutation(numbers.size - 1).to_a
  result = operation_sequences.map do |operation_sequence|
    result = numbers.first
    numbers[1..].each_with_index do |number, index|
      result = result.send(operation_sequence[index], number)
    end
    result if result == test_value
  end
  result.compact.uniq
end

result = results.flatten.sum

puts "Part 1: #{result}"
