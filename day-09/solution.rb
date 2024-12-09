disk_map = File.read("example.txt").chomp.split('').map(&:to_i)

disk = disk_map.map.with_index {|length, index| index.even? ? (index / 2).to_s * length : '.' * length}.join

def fragment_disk(disk)
  blocks = disk.chars
  last_file_index = blocks.rindex { |block| block != '.' }
  first_free_index = blocks.index('.')

  return blocks.join if first_free_index > last_file_index

  blocks[first_free_index], blocks[last_file_index] = blocks[last_file_index], blocks[first_free_index]
  blocks.join
end

disk = loop do
  fragmented_disk = fragment_disk(disk)
  break fragmented_disk if fragmented_disk == disk
  disk = fragmented_disk
  puts disk
end

checksum = disk.chars.reject { |block| block == '.' }.map.with_index { |block, index| block.to_i * index}.sum

puts "Part 1: #{checksum}"
