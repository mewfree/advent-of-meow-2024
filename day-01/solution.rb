lines = File.readlines("example.txt", chomp: true)
split_lines = lines.map(&:split)
left, right = split_lines.transpose
distances = left.sort.zip(right.sort).map { |a, b| (a.to_i - b.to_i).abs }
result = distances.sum

puts "Part 1: #{result}"

tally = right.tally
scores = left.map { |i| i.to_i * tally.fetch(i, 0) }
result2 = scores.sum

puts "Part 2: #{result2}"
