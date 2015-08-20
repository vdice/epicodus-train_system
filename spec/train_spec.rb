require('spec_helper')

describe(Train) do
  describe('#id') do
    it('returns the id of the train') do
      test_train = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train.save()
      expect(test_train.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#eta') do
    it('returns the eta of the train') do
      test_train = Train.new({:name => 'red',:eta => Time.new(2015), :id => nil})
      expect(test_train.eta()).to(eq(Time.new(2015)))
    end
  end

  describe('#name') do
    it('returns the name of the train') do
      test_train = Train.new({:name => 'red',:eta => Time.new(2015), :id => nil})
      expect(test_train.name()).to(eq('red'))
    end
  end

  describe('.all') do
    it('starts out empty') do
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a train to the list of trains') do
      test_train = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train2.save()
      expect(Train.all()).to(eq([test_train, test_train2]))
    end
  end

  describe('#update') do
    it('updates the train info') do
      test_train = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train.save()
      test_train.update({:name => 'blue', :eta => Time.new(1980)})
      expect(test_train.name()).to(eq('blue'))
      expect(test_train.eta()).to(eq(Time.new(1980)))
    end
    it('updates the train name') do
      test_train = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train.save()
      test_train.update({:name => 'blue'})
      expect(test_train.name()).to(eq('blue'))
    end
    it('updates the train eta') do
      test_train = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train.save()
      test_train.update({:eta => Time.new(2016)})
      expect(test_train.eta()).to(eq(Time.new(2016)))
    end
    it('updates cities for train') do
      test_train = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train.save()
      city1 = City.new({:name => 'Portland', :id => nil})
      city2 = City.new({:name => 'Boulder', :id => nil})
      city1.save()
      city2.save()
      test_train.update({:city_ids => [city1.id(), city2.id()]})
      expect(test_train.cities()).to(eq([city1, city2]))
    end
  end

  describe('#delete') do
    it('deletes the train') do
      test_train = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train2.save()
      test_train.delete()
      expect(Train.all()).to(eq([test_train2]))
    end
  end

  describe('.find') do
    it('returns a train instance based on id') do
      test_train = Train.new({:name => 'red',:eta => Time.new(), :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => 'blue',:eta => Time.new(1884), :id => nil})
      test_train2.save()
      expect(Train.find(test_train.id())).to(eq(test_train))
    end
  end
end
