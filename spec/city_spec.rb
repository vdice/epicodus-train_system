require('spec_helper')

describe(City) do
  describe('#name') do
    it('returns the name of the city') do
      test_city = City.new({:name => 'Portland', :id => nil})
      expect(test_city.name()).to(eq('Portland'))
    end
  end

  describe('#id') do
    it('returns the id of the city') do
      test_city = City.new({:name => 'Portland', :id => nil})
      test_city.save()
      expect(test_city.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('starts out empty') do
      expect(City.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a city') do
      test_city = City.new({:name => 'Portland', :id => nil})
      test_city.save()
      expect(City.all()).to(eq([test_city]))
    end
  end

  describe('#==') do
    it('returns true if the names and ids of two cities are the same') do
      city1 = City.new({:name => 'Portland', :id => nil})
      city2 = City.new({:name => 'Portland', :id => nil})
      expect(city1).to(eq(city2))
    end
  end

  describe('#delete') do
    it('lets you delete a city') do
      city1 = City.new({:name => 'Portland', :id => nil})
      city1.save()
      city2 = City.new({:name => 'Portland', :id => nil})
      city2.save()
      city1.delete()
      expect(City.all()).to(eq([city2]))
    end
  end

  describe('#update') do
    it('lets you update a city with a new name') do
      test_city = City.new({:name => 'Portland', :id => nil})
      test_city.save()
      test_city.update({:name => 'Fremont'})
      expect(test_city.name()).to(eq('Fremont'))
    end
  end

  describe('.find') do
    it('returns city based on id') do
      test_city = City.new({:name => 'Portland', :id => nil})
      test_city.save()
      expect(City.find(test_city.id())).to(eq(test_city))
    end
  end
end
