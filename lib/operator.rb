class Operator

  def initialize
  end

  def Operator.create
    new_op = Operator.new
    new_op
  end

  def Operator.add_station(station_name)
    DB.exec("INSERT INTO stations (name) VALUES ('#{station_name}');")
  end

  def Operator.add_line(line_name)
    DB.exec("INSERT INTO train_lines (name) VALUES ('#{line_name}');")
  end

  def Operator.add_stop(station_name, line_name)
    station_id = self.fetch_station_id(station_name)
    line_id = self.fetch_line_id(line_name)
    DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{station_id},#{line_id});")
  end

  def Operator.delete_stop(station_name, line_name)
    station_id = self.fetch_station_id(station_name)
    line_id = self.fetch_line_id(line_name)
    DB.exec("DELETE FROM stops WHERE station_id = #{station_id} AND line_id = #{line_id};")
  end

  def Operator.delete_line(line_name)
    line_id = self.fetch_line_id(line_name)
    DB.exec("DELETE FROM stops WHERE line_id = #{line_id};")
    DB.exec("DELETE FROM train_lines WHERE id = #{line_id};")
  end

  def Operator.fetch_station_id(station_name)
    results = DB.exec("SELECT * FROM stations WHERE name = '#{station_name}';")
    station_id = results.first["id"]
  end

  def Operator.fetch_line_id(line_name)
    results = DB.exec("SELECT * FROM train_lines WHERE name = '#{line_name}';")
    line_id = results.first["id"]
  end

  def Operator.fetch_line_name(line_id)
    results = DB.exec("SELECT * FROM train_lines WHERE id = #{line_id};")
    line_name = results.first["name"]
    # results2 = DB.exec("SELECT * FROM train_lines WHERE id = #{cur_line_id};")
    # line_name =results2.first['name']
  end

  def Operator.lines
    results = DB.exec("SELECT * FROM train_lines;")
    lines = []
    results.each do |result|
      name = result['name']
      lines << name
    end
    lines
  end

  def Operator.stations
    results = DB.exec("SELECT * FROM stations;")
    stations = []
    results.each do |result|
      name = result['name']
      # id = result['id']
      stations << name
    end
    stations
  end

  def Operator.stops(line_name)
    line_id = self.fetch_line_id(line_name)
    results = DB.exec("SELECT * FROM stops WHERE line_id = #{line_id};")
    stations = []
    results.each do |result|
      station_id = result['station_id']
      station = DB.exec("SELECT * FROM stations WHERE id = #{station_id};");
      stations << station.first['name']
    end
    stations
  end

end
