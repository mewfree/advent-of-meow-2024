base_map = File.readlines("example.txt", chomp: true).map(&:chars).freeze
map = base_map.map(&:dup)

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

previous_coordinates = []

map.each_with_index do |row, row_index|
  row.each_with_index do |element, col_index|
    previous_coordinates << [row_index, col_index] if element == 'X'
  end
end

options = []

previous_coordinates.each do |by, bx|
  tracker = Set.new

  # Reset map and directions
  map = base_map.map(&:dup)
  directions = direction_deltas.keys.cycle
  direction = directions.next

  y = map.find_index { |row| row.include?('^') }
  x = map[y].find_index('^')

  next if [x, y] == [bx, by]

  # Mark bx, by as "blocked"
  next if map[by].nil?
  map[by][bx] = '#'

  loop do
    dy, dx = direction_deltas[direction]
    ny, nx = y + dy, x + dx

    break if !ny.between?(0, map.length - 1)
    break if !nx.between?(0, map.first.length - 1)

    if map[ny][nx] == '#'
      direction = directions.next
    else
      y, x = ny, nx
      id = [x, y, direction]
      if tracker.include?(id)
        options << [bx, by]
        break
      end
      tracker << id
    end
  end
end

result2 = options.count

puts "Part 2: #{result2}"
