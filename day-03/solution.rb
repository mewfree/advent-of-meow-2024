memory = File.read("example.txt")

instructions = memory.scan(/mul\((\d{1,3}),(\d{1,3})\)/)

result = instructions.map { |a, b| a.to_i * b.to_i }.sum

puts "Part 1: #{result}"
