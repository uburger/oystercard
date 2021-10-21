require 'station'

describe Station do 

  describe '#name' do 
  
    it 'check if a new Station has a name' do
      expect(subject.name).to eq "cologne"
    end
  end

  describe '#zone' do 
  
    it 'check if a new Station has a zone' do
      expect(subject.zone).to eq 1
    end
  end
end
