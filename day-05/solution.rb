manual = File.readlines("example.txt", chomp: true).reject { |e| e.empty? }
raw_rules, raw_pages = manual.partition { |x| x.include?('|') }
rules = raw_rules.map { |e| e.split('|').map { |i| i.to_i } }
pages = raw_pages.map { |e| e.split(',').map { |i| i.to_i } }

def valid?(rules, update)
  rules.each do |p1, p2|
    next if !update.include?(p1) || !update.include?(p2)
    return false if update.index(p1) > update.index(p2)
  end

  true
end

valid_pages = pages.select { |p| valid?(rules, p) }
middle_pages = valid_pages.map { |pages| pages[pages.length / 2] }
result = middle_pages.sum

puts "Part 1: #{result}"

invalid_pages = pages.reject { |p| valid?(rules, p) }

def sort_page(rules, page)
  page.sort do |a, b|
    rule = rules.find { |x, y| [x, y].sort == [a, b].sort }
    rule.index(a) <=> rule.index(b)
  end
end

reordered_pages = invalid_pages.map { |page| sort_page(rules, page) }
middle_pages2 = reordered_pages.map { |pages| pages[pages.length / 2] }
result2 = middle_pages2.sum

puts "Part 2: #{result2}"
