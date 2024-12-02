file = File.open("example.txt")
lines = file.readlines.map(&:chomp)

split_lines = lines.map(&:split)

transposed = split_lines.transpose

left = transposed.first

right = transposed.last

distances = left.sort.zip(right.sort).map { |i| (i.first.to_i - i.last.to_i).abs }

result = distances.sum

puts "Part 1: #{result}"

tally = right.tally

scores = left.map { |i| i.to_i * (tally[i] || 0) }

result2 = scores.sum

puts "Part 2: #{result2}"
