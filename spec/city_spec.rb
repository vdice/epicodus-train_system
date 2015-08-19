require('spec_helper')

describe(City) do
  describe('#name') do
    it('returns the name of the city') do
      test_city = City.new({:name => 'Portland'})
      expect(test_city.name()).to(eq('Portland'))
    end
  end
end
