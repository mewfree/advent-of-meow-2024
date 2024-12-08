memory = File.read("example.txt")
instructions = memory.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
result = instructions.map { |a, b| a.to_i * b.to_i }.sum

puts "Part 1: #{result}"

instructions2 = memory.scan(/(do\(\)|don't\(\)|mul\((\d{1,3}),(\d{1,3})\))/)

filtered = instructions2.inject([]) do |result, element|
  @ignore = true if element == ["don't()", nil, nil]
  result << element unless @ignore
  @ignore = false if element == ["do()", nil, nil]
  result
end

result2 = filtered.map { |_, a, b| a.to_i * b.to_i }.sum

puts "Part 2: #{result2}"
