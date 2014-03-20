require 'spec_helper'

describe Operator do
  it 'creates an instance of an operator' do
    new_op = Operator.create
    new_op.should be_an_instance_of Operator
  end

  it 'contains an array of all the stations' do
    new_op = Operator.create
    Operator.stations.should eq []
  end

  it 'adds a station to the table' do
    new_op = Operator.create
    Operator.add_station('Broadway')
    Operator.add_station('Pearl')
    Operator.stations.should eq ['Broadway', 'Pearl']
  end

  it 'adds a line to the table' do
    new_op = Operator.create
    Operator.add_line('red')
    Operator.add_line('green')
    Operator.lines.should eq ['red', 'green']
  end

  it 'adds a stop to the join table' do
    new_op = Operator.create
    Operator.add_line('red')
    Operator.add_station('Broadway')
    Operator.add_stop('Broadway', 'red')
    Operator.stops('red').should eq ['Broadway']
  end
end
