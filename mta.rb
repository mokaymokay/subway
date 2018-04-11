require_relative 'structure'

mta = Subway.new
mta.add_line("N", ["times_square", "34th", "28th", "23rd", "union_square", "8th"])
mta.add_line("L", ["8th", "6th", "union_square", "3rd", "1st"])
mta.add_line("6", ["grand_central", "33rd", "28th", "23rd", "union_square", "astor_place"])
mta.add_line("Q", ["times_square", "herald_square", "union_square", "canal_st"])
mta.add_line("F", ["rockefeller_center", "42nd", "herald_square", "23rd", "14th", "west_4th"])

train_lines = mta.lines.keys

if ARGV.empty?
  mta.help
else
  case ARGV[0]
  when "lines"
    mta.display_lines
  when "stops"
    if ARGV[1]
      if train_lines.include?(ARGV[1].to_sym)
        mta.display_stops(ARGV[1])
      else
        print "We only have the following lines: "
        mta.display_lines
      end
    else
      puts "Please include a train line, i.e. 'ruby mta.rb stops L'"
    end
  when "calculate"
    if ARGV[1] && ARGV[2] && ARGV[3] && ARGV[4]
      # if both train lines exist
      if train_lines.include?(ARGV[1].to_sym) && train_lines.include?(ARGV[3].to_sym)
        # if start stop doesn't exist on start train line
        if not mta.lines[ARGV[1].to_sym].include?(ARGV[2])
          puts "The " + ARGV[1] + " train does not have that stop"
        # if end stop doesn't exist on end train line
        elsif not mta.lines[ARGV[3].to_sym].include?(ARGV[4])
          puts "The " + ARGV[3] + " train does not have that stop"
        else
          puts mta.calculate_distance(ARGV[1], ARGV[2], ARGV[3], ARGV[4])
        end
      else
        print "We only have the following lines: "
        mta.display_lines
      end
    else
      puts "You must provide START_LINE START_STOP END_LINE END_STOP, i.e. 'ruby mta.rb calculate 6 astor_place N times_square'"
    end
  else
    mta.help
  end
end
