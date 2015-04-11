# Parallel found here : https://github.com/grosser/parallel
require 'parallel'

def cookies(cps,c,f,x)
  cookies_per_second = cps
  time = 0.0

  while eta_with_farm(cookies_per_second, c, f, x) < eta(cookies_per_second, x) do
    time += eta(cookies_per_second, c)
    cookies_per_second += f
  end

  return "%0.7f" % (time + eta(cookies_per_second, x))
end

def eta(cps, cookies)
  cookies / cps
end

def eta_with_farm(cps, c, f, cookies)
  eta(cps, c) + eta(cps+f, cookies)
end

def main
  f = File.open("input.txt", "r")
  lines = f.readlines 
  f.close

  # Iterate over lines, parse, and solve
  num_problems = lines.shift.to_i
  inputs = []

  (1..num_problems).each do |problem|
    inputs.push(lines.shift.split(" ").map { |s| s.to_f })
  end

  results = Parallel.map_with_index(inputs, :in_processes=>8) do |input, index|
    c = input.shift
    f = input.shift
    x = input.shift
    "Case ##{index+1}: #{cookies(2.0,c,f,x)}"
  end

  results.each do |result|
    puts result
  end
end

# Run the main method...
main