require('spec_helper')

describe(Stop) do
  describe('#eta') do
    it('returns eta') do
      train = Train.new({:name => 'Budapest Lightning', :id => nil})
      city = City.new({:name => 'Budapest', :id => nil})
      train.save()
      city.save()
      stop = Stop.new({:train => train, :city => city, :eta => Time.new(2015)})
      stop.save()
      expect(stop.eta()).to(eq(Time.new(2015)))
    end
  end
end
