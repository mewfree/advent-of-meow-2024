map = File.readlines("example.txt", chomp: true).map(&:chars)

y = map.find_index { |row| row.include?('^') }
x = map[y].find_index('^')

direction_deltas = {
  'up' => [-1, 0],
  'right' => [0, 1],
  'down' => [1, 0],
  'left' => [0, -1],
}

directions = direction_deltas.keys.cycle
direction = directions.next

map[y][x] = 'X'

loop do
  dy, dx = direction_deltas[direction]
  ny, nx = y + dy, x + dx

  break if !ny.between?(0, map.length - 1)
  break if !nx.between?(0, map.first.length - 1)

  if map[ny][nx] == '#'
    direction = directions.next
  else
    map[ny][nx] = 'X'
    y, x = ny, nx
  end
end

result = map.flatten.count('X')

puts "Part 1: #{result}"
