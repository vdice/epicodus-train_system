require('spec_helper')

describe(City) do
  describe('#name') do
    it('returns the name of the city') do
      test_city = City.new({:name => 'Portland'})
      expect(test_city.name()).to(eq('Portland'))
    end
  end

  describe('#id') do
    it('returns the id of the city') do
      test_city = City.new({:name => 'Portland'})
      test_city.save()
      expect(test_city.id()).to(be_an_instance_of(Fixnum))
    end
  end
end
