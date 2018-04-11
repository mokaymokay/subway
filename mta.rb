require_relative 'structure'

mta = Subway.new
mta.add_line("N", ["times_square", "34th", "28th", "23rd", "union_square", "8th"])
mta.add_line("L", ["8th", "6th", "union_square", "3rd", "1st"])
mta.add_line("6", ["grand_central", "33rd", "28th", "23rd", "union_square", "astor_place"])

# p mta.lines["6".to_sym]
# p mta.lines["N".to_sym].index("Union Sq")

train_stops = mta.lines.keys

if ARGV.empty?
  mta.help
else
  if ARGV[0] == "lines"
    mta.display_lines
  elsif ARGV[0] == "stops"
    if train_stops.include?(ARGV[1].to_sym)
      mta.display_stops(ARGV[1])
    else
      puts "We only have the following lines:"
      mta.display_lines
    end
  elsif ARGV[0] == "calculate"
    if train_stops.include?(ARGV[1].to_sym) && train_stops.include?(ARGV[3].to_sym)
      mta.calculate_distance(ARGV[1], ARGV[2], ARGV[3], ARGV[4])
    else
      puts "You must provide 4 arguments - STARTINGLINE STOP ENDINGLINE STOP"
    end
  else
    mta.help
  end
end
