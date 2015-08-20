require('spec_helper')

describe(Stop) do
  describe('#eta') do
    it('returns eta') do
      train = Train.new({:name => 'Budapest Lightning', :id => nil})
      city = City.new({:name => 'Budapest', :id => nil})
      stop = Stop.new({:train => train, :city => city, :eta => Time.new(2015)})
      expect(stop.eta()).to(eq(Time.new(2015)))
    end
  end

  describe('.all') do
    it('returns empty list initially') do
      expect(Stop.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a stop') do
      train = Train.new({:name => 'Budapest Lightning', :id => nil})
      train.save()
      city = City.new({:name => 'Budapest', :id => nil})
      city.save()
      stop = Stop.new({:train => train, :city => city, :eta => Time.new(2015)})
      stop.save()
      expect(Stop.all()).to(eq([stop]))
    end
  end

  describe('#city') do
    it('returns the city') do
      train = Train.new({:name => 'Budapest Lightning', :id => nil})
      city = City.new({:name => 'Budapest', :id => nil})
      stop = Stop.new({:train => train, :city => city, :eta => Time.new(2015)})
      expect(stop.city()).to(eq(city))
    end
  end
end
