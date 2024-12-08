calibrations = File.readlines("example.txt", chomp: true).inject({}) do |hash, calibration|
  test_value, numbers = calibration.split(': ')
  hash[test_value.to_i] = numbers.split.map(&:to_i)
  hash
end

operators = [
  ->(a, b) { a + b },
  ->(a, b) { a * b },
]

def calculate_results(calibrations, operators)
  calibrations.map do |test_value, numbers|
    operation_sequences = operators.repeated_permutation(numbers.size - 1).to_a
    operation_sequences.map do |operation_sequence|
      result = numbers.first
      numbers[1..].each_with_index do |number, index|
        result = operation_sequence[index].call(result, number)
      end
      result if result == test_value
    end.compact.uniq
  end
end

results = calculate_results(calibrations, operators)
result = results.flatten.sum

puts "Part 1: #{result}"

operators << ->(a, b) { (a.to_s + b.to_s).to_i }

results2 = calculate_results(calibrations, operators)
result2 = results2.flatten.sum

puts "Part 2: #{result2}"
