class Subway
  attr_reader :lines

  def initialize(lines = {})
    @lines = lines
  end

  def add_line(name, stops =[])
    Line.new(name, stops)
    @lines[name.to_sym] = stops
  end

  def help
    puts "Enter 'ruby mta.rb lines' to see all train lines"
    puts "Enter 'ruby mta.rb stops LINE' to see a train's stops, i.e. 'ruby mta.rb stops 6'"
    puts "Enter 'ruby mta.rb calculate STARTINGLINE STOP ENDINGLINE STOP' to calculate distance between two train stops, i.e. 'ruby mta.rb calculate 6 grand_central 6 astor_place'"
  end

  def display_lines
    print @lines.keys.join(", ")
    puts
  end

  def display_stops(name)
    puts @lines[name.to_sym].join(", ")
  end

  def calculate_distance(start_line, start_stop, end_line, end_stop)

    if start_line == end_line
      dist = @lines[start_line.to_sym].index(start_stop) - @lines[end_line.to_sym].index(end_stop)
      puts dist.abs
    else
      # if traveling to/from F train stop
      if start_line == "F" || end_line == "F"
         # AND not traveling to/from Q train stop
        if start_line != "Q" && end_line != "Q"
          puts "You'll have to transfer more than once"
          # calculate using herald square transfer point
        else
          start_dist_from_herald_sq = @lines[start_line.to_sym].index(start_stop) - @lines[start_line.to_sym].index("herald_square")
          end_dist_from_herald_sq = @lines[end_line.to_sym].index(end_stop) - @lines[end_line.to_sym].index("herald_square")
          puts start_dist_from_herald_sq.abs + end_dist_from_herald_sq.abs
        end
        # rest of the trains have union square as transfer point
      else
        start_dist_from_union_sq = @lines[start_line.to_sym].index(start_stop) - @lines[start_line.to_sym].index("union_square")
        end_dist_from_union_sq = @lines[end_line.to_sym].index(end_stop) - @lines[end_line.to_sym].index("union_square")
        puts start_dist_from_union_sq.abs + end_dist_from_union_sq.abs
      end
    end
  end

end

class Line

  def initialize(name, stops = [])
    @name = name
    @stops = stops
  end

end
