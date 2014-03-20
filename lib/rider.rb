class Rider

  attr_reader :name, :start, :destination, :start_id, :destination_id

  def initialize(name, start, destination)
    @name = name
    @start = start
    @destination = destination
    @start_id = Operator.fetch_station_id(start)
    @destination_id = Operator.fetch_station_id(destination)
  end

  def Rider.create(name, start, destination)
    new_rider = Rider.new(name, start, destination)
    new_rider.save
    new_rider
  end

  def Rider.all
    results = DB.exec("SELECT * FROM riders;")
    riders = []
    results.each do |result|
      name = result['name']
      start_id = result['start_id']
      destination_id = result['destination_id']
      riders << Rider.new(name, start_id, destination_id)
    end
    riders
  end

  def save
    @start_id = Operator.fetch_station_id(@start)
    @destination_id = Operator.fetch_station_id(@destination)
    DB.exec("INSERT INTO riders (name, start_id, destination_id) VALUES ('#{@name}', #{@start_id}, #{@destination_id})")
  end

  # def change_station(new_station)
  #   new_station_id = Operator.fetch_station_id(new_station)
  #   DB.exec("UPDATE riders SET station_id = #{new_station_id} WHERE name = '#{self.name}';")
  # end

  def find_line(station)
    station_id = Operator.fetch_station_id(station)
    lines = []
    results = DB.exec("SELECT * FROM stops WHERE station_id = #{station_id};")
    results.each do |result|
      line_id = result.first
      lines << line_id
    end
    lines
  end

  def search_lines(start_lines, dest_lines)
    your_line_stations = []
    start_lines.each do |line_id|
      line_name = Operator.fetch_line_name(line_id[1].to_i)
      your_line_stations << Operator.stops(line_name)
    end

    if your_line_stations.include?(destination_id)
      puts "on same line"
    end


  end


end
