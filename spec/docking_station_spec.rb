require 'docking_station'

describe DockingStation do

  it { is_expected.to respond_to(:release_bike) }
  it { is_expected.to respond_to(:dock_bike).with(1).argument }
  # it { is_expected.to respond_to(:new).with(1).argument }
  #
  # describe '.new' do
  #   it 'takes one argument' do
  #     expect(subject("a")).to respond_to(:new).with(1).argument
  #   end
  # end

  describe 'initialization' do
    it "instantiates new docking stations with a default capacity of 20" do
      expect(subject.capacity).to eq 20
    end

    it "allows the user to set capacity when instantiating a new docking station" do
      docking_station = DockingStation.new(25)
      expect(docking_station.capacity).to eq 25
    end
  end

  describe '#release_bike' do
    it "tests that the release_bike method returns a bike" do
      bike = Bike.new
      subject.dock_bike(bike)
      expect(subject.release_bike).to be_an_instance_of Bike
    end
    # uses rspec 'predicate' syntax
    it "tests that the released bike is working" do
      bike = Bike.new
      subject.dock_bike(bike)
      expect(subject.release_bike.working).to eq true
    end

    it "tests that docking stations won't release broken bikes" do
      bike = Bike.new
      subject.dock_bike(bike, false)
      expect {subject.release_bike}.to raise_error("No working bikes available")
    end

    it "tests that docking station won't release broken bikes but will release working bikes" do
      working_bike = Bike.new
      broken_bike = Bike.new(false)
      subject.dock_bike(broken_bike)
      subject.dock_bike(working_bike)
      expect(subject.release_bike).to eq working_bike
    end

    it "raises an error if docking station is empty" do
      expect {subject.release_bike}.to raise_error("No bikes available")
    end

  end

  describe '#dock_bike' do
    it "raises an error if docking station is full" do
      (subject.capacity).times do
        subject.dock_bike(Bike.new)
      end
    expect {subject.dock_bike(Bike.new)}.to raise_error("Docking station is full")
    end

    it "updates working status if broken" do
      bike = Bike.new
      subject.dock_bike(bike,false)
      expect(bike.working).to eq false
    end

    describe '#dock_bike returns bikes' do
      before :each do
        @bike = Bike.new
        subject.dock_bike(@bike)
      end
      it "shows a bike that has been docked" do
        expect(subject.bikes).to eq([@bike])
      end

      it "returns an array" do
        expect(subject.bikes).to be_kind_of(Array)
      end

      it "adds a new bike to the end of the array" do
        expect(subject.bikes[-1]).to eq(@bike)
      end
    end

  end
end
