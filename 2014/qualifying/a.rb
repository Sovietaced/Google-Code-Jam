def magic_trick(first_cards, second_cards)
  intersect = first_cards & second_cards
  if intersect.empty?
    puts "Volunteer cheated!" 
  elsif intersect.count > 1
    puts "Bad magician!"
  else
    p intersect.shift
  end
end

def get_cards(lines, row)
  cards = []
  lines.each do |line|
    cards.push(line.split(" ").map { |s| s.to_i })
  end
  return cards[row-1]
end

def main
  f = File.open("input.txt", "r")
  lines = f.readlines 
  f.close

  # Iterate over lines, parse, and solve
  num_problems = lines.shift.to_i
  (1..num_problems).each do |problem|
    first_row = lines.shift.to_i
    first_cards = get_cards(lines.shift(4), first_row)
    second_row = lines.shift.to_i
    second_cards = get_cards(lines.shift(4), second_row)
    print "Case ##{problem}: "
    magic_trick(first_cards, second_cards)
  end
end

# Run the main method...
main