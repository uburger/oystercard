require 'journey'

describe Journey do 

  describe '#journey_list' do

    it 'checks if new card has an empty list of journeys' do
      expect(subject.journey_list).to be nil
    end
  end
end
