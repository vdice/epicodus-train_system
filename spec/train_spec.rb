require('spec_helper')

describe(Train) do
  describe('#id') do
    it('returns the id of the train') do
      test_train = Train.new({:id => nil, :eta => Time.new(), :city_id => 1})
      test_train.save()
      expect(test_train.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#eta') do
    it('returns the eta of the train') do
      test_train = Train.new({:id => nil, :eta => Time.new(2015), :city_id => 1})
      expect(test_train.eta()).to(eq(Time.new(2015)))
    end
  end

  describe('#city_id') do
    it('returns the city_id of the train') do
      test_train = Train.new({:id => nil, :eta => Time.new(), :city_id => 1})
      expect(test_train.city_id()).to(eq(1))
    end
  end
end
