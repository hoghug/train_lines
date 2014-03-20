require 'spec_helper'


describe Rider do
  it 'creates a rider with a name' do
    Operator.add_station('Broadway')
    Operator.add_station('Cerulean')
    new_rider = Rider.create('Brock','Broadway','Cerulean')
    new_rider.should be_an_instance_of Rider
  end

  it 'adds what station they are currently at' do
    Operator.add_station('Broadway')
    Operator.add_station('Cerulean')
    new_rider = Rider.create('Brock','Broadway','Cerulean')
    Rider.all.length.should eq 1
  end

  it 'changes the riders current station' do
    Operator.add_station('Broadway')
    Operator.add_station('Cerulean')
    new_rider = Rider.create('Brock','Broadway','Cerulean')
    new_rider.change_station('Cerulean')
    Rider.all.should eq [new_rider]
  end


end
