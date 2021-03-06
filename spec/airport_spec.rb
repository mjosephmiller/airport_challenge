require 'airport'

describe Airport do

  subject(:airport) { described_class.new(Airport::DEFAULT_CAPACITY, weather) }
  let(:airplane) {double(:airplane)}
  let(:weather) {double(:weather)}

  describe 'initialize' do
    it 'should have a default capacity if none is given' do
      airport = Airport.new
      expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
    end

    it 'should have the capacity if one is passed as an argument' do
      airport = Airport.new(20)
      expect(airport.capacity).to eq 20
    end
    it 'should be empty on initialization' do
      expect(airport.get_airplanes.length).to eq 0
    end
  end

  describe '# accept_landing' do
    it 'should increase airplanes array by 1' do
      allow(weather).to receive(:stormy?).and_return(false)
      airport.accept_landing(airplane)
      expect(airport.get_airplanes.length).to eq 1
    end

    it 'raises an error if the weather is stormy' do
      allow(weather).to receive(:stormy?).and_return(true)
      expect{airport.accept_landing(airplane)}.to raise_error 'The weather is stormy. Your flight will have to be rerouted.'
    end

    it 'raises an error if the airport is full' do
      allow(weather).to receive(:stormy?).and_return(false)
      subject.capacity.times {subject.accept_landing(airplane)}
      expect{airport.accept_landing(airplane)}.to raise_error 'The airport is full'
    end
  end

  describe '# accept_takeoff' do
    it 'should decrease airplanes array by 1' do
      allow(weather).to receive(:stormy?).and_return(false)
      airport.accept_landing(airplane)
      airport.accept_landing(airplane)
      airport.accept_takeoff(airplane)
      expect(airport.get_airplanes.length).to eq 1
    end

    it 'raises an error if the weather is stormy' do
      allow(weather).to receive(:stormy?).and_return(true)
      expect{airport.accept_takeoff(airplane)}.to raise_error 'The weather is stormy. Your flight will have to be rescheduled.'
    end
  end



end
