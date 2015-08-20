require('spec_helper')

describe(City) do
  before do
    @city = City.new({:name => 'Portland', :id => nil})
    @city2 = City.new({:name => 'Portland', :id => nil})
  end

  describe('#name') do
    it('returns the name of the city') do
      expect(@city.name()).to(eq('Portland'))
    end
  end

  describe('#id') do
    it('returns the id of the city') do
      @city.save()
      expect(@city.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('starts out empty') do
      expect(City.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a city') do
      @city.save()
      expect(City.all()).to(eq([@city]))
    end
  end

  describe('#==') do
    it('returns true if the names and ids of two cities are the same') do
      expect(@city).to(eq(@city2))
    end
  end

  describe('#delete') do
    it('lets you delete a city') do
      @city.save()
      @city2.save()
      @city.delete()
      expect(City.all()).to(eq([@city2]))
    end
  end

  describe('#update') do
    it('lets you update a city with a new name') do
      @city.save()
      @city.update({:name => 'Fremont'})
      expect(@city.name()).to(eq('Fremont'))
    end
  end

  describe('.find') do
    it('returns city based on id') do
      @city.save()
      expect(City.find(@city.id())).to(eq(@city))
    end
  end
end
