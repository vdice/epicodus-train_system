require('spec_helper')

describe(Stop) do
  before do
    @train = Train.new({:name => 'Budapest Lightning', :id => nil})
    @city = City.new({:name => 'Budapest', :id => nil})
    @stop = Stop.new({:train => @train, :city => @city, :eta => Time.new(2015), :id => nil})
  end

  describe('#eta') do
    it('returns eta') do
      expect(@stop.eta()).to(eq(Time.new(2015)))
    end
  end

  describe('#id') do
    it('returns id') do
      @train.save()
      @city.save()    
      @stop.save()
      expect(@stop.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('returns empty list initially') do
      expect(Stop.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a stop') do
      @train.save()
      @city.save()
      @stop.save()
      expect(Stop.all()).to(eq([@stop]))
    end
  end

  describe('#city') do
    it('returns the city') do
      expect(@stop.city()).to(eq(@city))
    end
  end

  describe('#train') do
    it('returns the train') do
      expect(@stop.train()).to(eq(@train))
    end
  end
end
