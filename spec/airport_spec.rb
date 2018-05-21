require_relative '../lib/airport.rb'

describe Airport do 
  let(:plane) { double :plane }

  before(:each) do
    allow(subject).to receive(:weather_generator).and_return(50)
  end

  describe 'initialize' do 
    it 'should set default capacity as 30 planes' do
      subject
      expect(subject.capacity).to eq 30
    end
    # The default capacity is hard-coded, which is fine for now
    # Otherwise put DEFAULT_CAPACITY = 30 in your class
    # and test it saying
    # expect(Airport::DEFAULT_CAPACITY).to eq 30

    it 'should allow you change default capacity' do
      airport = described_class.new(20)
      expect(airport.capacity).to eq 20 
    end
  end

  describe '#land' do 
    it 'responds to land with 1 argument' do
      expect(subject).to respond_to(:land).with(1).argument
    end
    # responds with 1 argument is unnecessary
    # seeing as other tests do that already
    it 'can instruct a plane to land' do
      expect { subject.land(:plane) }.not_to raise_error 
    end
    # The next test takes care of this already.
    it 'alerts the user that their plane has been stored' do
      expect(subject.land(:plane)).to eq "Your plane has been successfully stored"
    end
    # The next test takes care of this already.
    it 'can store the plane in the airport hangar' do
      subject.land(:plane)
      expect(subject.planes).to include(:plane)
    end
    it 'can land multiple planes' do
      subject.land(:plane)
      expect { subject.land(:plane) }.not_to raise_error
    end
    it 'can hold multiple planes in its hangar' do
      5.times { subject.land(:plane) }
      expect(subject.planes.length).to eq 5
    end
    it 'shouldnt land the plane if its stormy' do 
      allow(subject).to receive(:weather_generator).and_return(80)
      expect { subject.land(:plane) }.to raise_error "Plane can't land in stormy weather"
    end
    it 'wont allow plane to land if airport is full for default capacity' do
      subject.capacity.times { subject.land(:plane) }
      expect { subject.land(:plane) }.to raise_error "Cannot land plane, airport is full"
    end
    it 'wont allow plane to land for custom capacity' do 
      airport = described_class.new(2)
      allow(airport).to receive(:weather_generator).and_return(50)
      airport.land(:plane) 
      airport.land(:plane)
      expect { airport.land(:plane) }.to raise_error "Cannot land plane, airport is full"
    end 
  end

  describe '#take_off' do
    let(:plane) { double :plane }
    it 'responds to take_off' do
      expect(subject).to respond_to(:take_off)
    end
    # unnecessary seeing as other tests do this already
    it 'should be able to return a plane to the user' do 
      subject.land(:plane)
      expect(subject.take_off).to eq :plane
    end
    it 'should have 1 less plane in its hangar after taking one off' do
      3.times { subject.land(:plane) }
      subject.take_off 
      expect(subject.planes.length).to eq 2
    end
    it 'no longer has the plane that has taken off in its hangar' do 
      plane = double(:plane)
      3.times { subject.land(plane) }
      plane = subject.take_off
      expect(subject.planes.length).not_to eq 3
    end 
    it 'should show an error when no planes are available' do 
      expect { subject.take_off }.to raise_error "No planes available"
    end
    it 'shouldnt take off if the weather is stormy' do 
      subject.land(:plane)
      allow(subject).to receive(:stormy?).and_return(true)
      expect { subject.take_off }.to raise_error "Plane can't take off in stormy weather"
    end
    it 'should take off if the weather isnt stormy' do 
      subject.land(:plane)
      allow(subject).to receive(:stormy).and_return(false)
      expect { subject.take_off }.not_to raise_error
    end
    it 'should only allow planes that are in its hangar to take off' do
      expect { subject.take_off(:plane) }.to raise_error "That plane is not in this airport"
    end
    it 'should allow user to specify planes to take off, removing that plane from its hangar' do
      plane = double(:plane)
      subject.land(plane)
      subject.land(plane)
      subject.land(plane)
      allow(plane).to receive(:take_flight).and_return(true)
      subject.take_off(plane)
      allow(plane).to receive(:take_flight).and_return(true)
      expect(subject.planes.length).not_to eq 3
    end
    it 'when taking off a specific plane, should return that plane to user' do
      plane = double(:plane)
      allow(plane).to receive(:take_flight).and_return(true)
      subject.land(plane)
      expect(subject.take_off(plane)).to eq plane
    end
    # This is a super important and meaningful test! Good job!

    it 'tells the plane that it is flying after it takes off' do
      plane = double(:plane)
      allow(plane).to receive(:take_flight).and_return(true)
      allow(plane).to receive(:flying?).and_return(true)
      subject.land(plane)
      subject.take_off(plane)
      expect(plane).to be_flying
    end
  end

  describe '#check_plane' do 
    it 'should return false when the plane isnt in the hangar' do
      subject.land(:plane)
      allow(subject).to receive(:weather_generator).and_return(50)
      plane = subject.take_off
      expect(subject.check_plane(plane)).to eq false
    end
    it 'should return true when the plane is in the hangar' do
      subject.land(:plane)
      expect(subject.check_plane(:plane)).to eq true
    end
  end
  # plane_in_hangar would be less confusing name for the method

  describe '#stormy?' do
    it 'should return true if random weather generator is 75 or above' do
      allow(subject).to receive(:weather_generator).and_return(80)
      expect(subject).to be_stormy 
      allow(subject).to receive(:weather_generator).and_return(75)
      expect(subject).to be_stormy 
    end
    it 'should return false if random weather generator is under 75' do
      allow(subject).to receive(:weather_generator).and_return(25) 
      expect(subject).not_to be_stormy
    end
  end
  # Hahaha, this is a truly vacuous test! =D
  # Your "return a number between 1-100" test should be enough. 

  describe '#weather_generator' do 
    it 'should return a number between 1-100' do
      expect(subject.weather_generator).to be_between(1, 100).inclusive
    end
  end
  # nice one

  describe '#full?' do 
    it 'returns true if there are as many planes in hangar as the capacity' do
      30.times { subject.land(:place) }
      expect(subject).to be_full
    end
  end
end
