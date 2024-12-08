reports = File.readlines("example.txt", chomp: true).map(&:split)

def is_safe?(report)
  diffs = report.map(&:to_i).each_cons(2).map { |a, b| (a - b) }
  all_increasing = diffs.all? { |i| i.between?(-3, -1) }
  all_decreasing = diffs.all? { |i| i.between?(1, 3) }
  all_increasing || all_decreasing
end

safe_reports = reports.map { |report| is_safe?(report) }
result = safe_reports.count(true)

puts "Part 1: #{result}"

def is_safe2?(report)
  return true if is_safe?(report)

  report.each_index do |n|
    return true if is_safe?(report.reject.with_index {|_, i| i == n })
  end

  false
end

safe_reports2 = reports.map { |report| is_safe2?(report) }
result2 = safe_reports2.count(true)

puts "Part 2: #{result2}"
