map = File.readlines("example.txt", chomp: true).map(&:chars)

antennas = map.each_with_index.with_object(Hash.new { |h, k| h[k] = [] }) do |(row, row_index), locations|
  row.each_with_index do |cell, col_index|
    locations[cell] << [col_index, row_index] unless cell == '.'
  end
end

def calculate_antinodes(antenna_pair, max_x, max_y)
  x1, y1, x2, y2 = antenna_pair.flatten

  delta_x = x2 - x1
  delta_y = y2 - y1

  antinode_1 = {x: (x1 - delta_x), y: (y1 - delta_y)}
  antinode_2 = {x: (x2 + delta_x), y: (y2 + delta_y)}

  antinode_1 = nil if antinode_1[:x] < 0 || antinode_1[:y] < 0 || antinode_1[:x] >= max_x || antinode_1[:y] >= max_y
  antinode_2 = nil if antinode_2[:x] < 0 || antinode_2[:y] < 0 || antinode_2[:x] >= max_x || antinode_2[:y] >= max_y

  [antinode_1, antinode_2]
end

antinodes = antennas.values.flat_map do |frequency|
  frequency.combination(2).flat_map do |antenna_pair|
    calculate_antinodes(antenna_pair, map[0].size, map.size)
  end
end.compact

result = antinodes.uniq.size

puts "Part 1: #{result}"
