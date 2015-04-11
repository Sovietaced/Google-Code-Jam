def standing_ovation(max, people)
  # init with number of people that will stand the entire time
  current_standing = people.shift.to_i
  needed_to_add = 0

  # Strange case
  if max == 0
    return 0
  end

  # index is the number needed to stand
  people.each_with_index do |num_people, index|
    needed_to_stand = index + 1

    #puts "#{(current_standing + needed_to_add)} for #{needed_to_stand}"
    if (current_standing + needed_to_add) >= needed_to_stand
      #puts "enough current standing for needed to stand #{needed_to_stand}"
      current_standing += num_people.to_i
    else
      #puts "incrementing needed to add at #{needed_to_stand}"
      current_standing += num_people.to_i
      needed_to_add += 1
    end

    if (current_standing + needed_to_add) >= max 
      return needed_to_add
    end
  end

end

def main
  f = File.open("input.txt", "r")
  lines = f.readlines 
  f.close

  # Iterate over lines, parse, and solve
  num_problems = lines.shift.to_i
  (1..num_problems).each do |problem|
    line = lines.shift.strip.split("")
    max = line.shift.to_i
    people = line[1..-1]
    puts "Case ##{problem}: #{standing_ovation(max, people)}"
  end
end

# Run the main method...
main