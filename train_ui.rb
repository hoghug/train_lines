require 'pg'
require './lib/operator'
require './lib/rider'

DB = PG.connect({:dbname => 'train_stations'})


def set_up
  system('clear')
  puts "rider or operator?"
  input = gets.chomp
  if input[0] == 'r'
    system('clear')
    puts 'what is your name: '
    rider_name = gets.chomp
    system('clear')
    show_lines
    puts 'what is your location(where from?): '
    rider_start = gets.chomp
    puts 'what is your quest..(where to?): '
    rider_destination = gets.chomp
    current_rider = Rider.create(rider_name, rider_start, rider_destination)
    rider_menu(current_rider)
  elsif input[0] == 'o'
    puts "What is the operator password"
    input = gets.chomp
    if input == "1"
      operator_menu
    else
      puts "☭ эяяоя ☭"
      sleep(1)
      set_up
    end
  else
    error
    set_up
  end
end

def operator_menu
  system('clear')
  puts "1: Add Station, 2: Add Line, 3: Add Stop, 4: Display lines, 5: Delete stop/lines"
  case gets.chomp
  when '1'
    add_station
  when '2'
    add_line
  when '3'
    add_stop
  when '4'
    show_lines
    puts "press any key to return to main menu"
    gets.chomp
    operator_menu
  when '5'
    delete_data
  else
    error
    operator_menu
  end
end

def error
  puts "☭ эяяоя ☭"
    sleep(1)
end

def add_station
  system('clear')
  puts "enter the name of the station"
  input = gets.chomp
  Operator.add_station(input)
  operator_menu
end

def add_line
  system('clear')
  puts "enter the name of the line"
  input = gets.chomp
  Operator.add_line(input)
  operator_menu
end

def add_stop
  system('clear')
  Operator.lines.each_with_index do |line, index|
    puts "#{index + 1}: #{line}"
  end
  puts "select which line you want to add a stop to"
  line_name = Operator.lines[gets.chomp.to_i - 1]
  system('clear')
  Operator.stations.each_with_index do |station, index|
    puts "#{index + 1}: #{station}"
  end
  puts "which stations do you want to add to the #{line_name} line (space in between each)"
  station_ids = gets.chomp.split

  station_ids.each do |id|
    Operator.add_stop(Operator.stations[id.to_i - 1], line_name)
  end
  operator_menu
end

def delete_data
  show_lines
  puts "which line do you want to destroy/damage"
  line_to_change = gets.chomp
  puts "list the stops you want to destroy separated by a comma or 'all' to destroy the line"
  input = gets.chomp.split(", ")
  begin
    if input.include?("all")
      Operator.delete_line(line_to_change)
    else
      input.each do |stop|
        Operator.delete_stop(stop, line_to_change)
      end
    end
  rescue
    error
  end
  operator_menu
end

def show_lines
  Operator.lines.each do |line|
    output = "line: " + line + ": ["
    output += Operator.stops(line).join(", ")
    puts output + "]"
  end
end

def rider_menu(current_rider)
  puts "1: Change station, 2: Display lines, 3: plan a trip"
  case gets.chomp
  when '1'

  when '2'
    system('clear')
    show_lines
    puts "press any key to return to main menu"
    gets.chomp
    rider_menu(current_rider)
  when '3'
    trip_planner(current_rider)
  else
    error
    rider_menu(current_rider)
  end
end

def trip_planner(current_rider)
  start_lines = current_rider.find_line(current_rider.start)
  dest_lines = current_rider.find_line(current_rider.destination)

  current_rider.search_lines(start_lines, dest_lines)
  gets.chomp
end


#program load
set_up
