require 'docking_station'

describe Bike do
  # it { is_expected.to respond_to(:working?) }
  it "is working" do 
  	expect(subject.working).to eq true
  end

  # it "update status if in good condition" do 
  # 	expect(subject.working = true).to eq true
  # end


end
