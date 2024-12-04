grid = File.readlines("example.txt", chomp: true)

def count_word(grid)
  rows = grid.length
  cols = grid[0].length
  directions = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0],
    [1, 1],
    [-1, -1],
    [1, -1],
    [-1, 1],
  ]

  def valid?(grid, x, y, dx, dy, rows, cols)
    word = "XMAS"
    word.length.times do |k|
      nx, ny = x + k * dx, y + k * dy
      return false if nx < 0 || nx >= rows || ny < 0 || ny >= cols || grid[nx][ny] != word[k]
    end

    true
  end

  count = 0
  (0...rows).each do |x|
    (0...cols).each do |y|
      directions.each do |dx, dy|
        count += 1 if valid?(grid, x, y, dx, dy, rows, cols)
      end
    end
  end

  count
end

result = count_word(grid)

puts "Part 1: #{result}"
