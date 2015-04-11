def infinite_house_of_pancakes(num_people, distribution)

  #puts "inifinite house of pancakes called for #{distribution}"
  minutes = 0
  distribution = distribution.sort { |x, y| y <=> x }

  max = distribution[0]
  min = distribution[-1]

  # Possibly split
  if max > 2
    # Determine if we should just split or add to another plate...

    size = distribution.count

    split_savings = max / 2
    #puts "split savings #{split_savings}"

    if size > 1
      move_savings = max - ((max + min) / 2)
    else 
      move_savings = -1
    end

   # puts "move savings #{move_savings}"

    split_distribution = distribution.dup
    move_distribution = distribution.dup
    split_minutes = nil
    move_minutes = nil

    if split_savings > size
      # split it up
      split_distribution[0] = max - split_savings
      split_distribution.push(split_savings)
      #puts "splitting"
      split_minutes = 1 + infinite_house_of_pancakes(num_people, split_distribution)
      #puts "split minutes #{split_minutes}"
    end

    if move_savings > size 
      # move it over
      move_distribution[0] = max - move_savings
      move_distribution[-1] = max - move_savings
      #puts "moving"
      move_minutes = 1 + infinite_house_of_pancakes(num_people, move_distribution)
      #puts "move minutes #{move_minutes}"
    end

    if split_minutes and move_minutes
      return [split_minutes, move_minutes].min
    elsif split_minutes
      return split_minutes
    elsif move_minutes
      return move_minutes
    end
  end

  # base case, eat pancakes
  #puts "hit base case"
  return max
end

def main
  f = File.open("input.txt", "r")
  lines = f.readlines 
  f.close

  # Iterate over lines, parse, and solve
  num_problems = lines.shift.to_i
  (1..num_problems).each do |problem|
    num_people = lines.shift.to_i
    distribution = lines.shift.split(" ").map{|person| person.to_i}
    puts "Case ##{problem}: #{infinite_house_of_pancakes(num_people, distribution)}"
  end
end

# Run the main method...
main