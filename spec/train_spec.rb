require('spec_helper')

describe(Train) do
  describe('#id') do
    it('returns the id of the train') do
      test_train = Train.new({:id => nil, :eta => Time.new()})
      test_train.save()
      expect(test_train.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#eta') do
    it('returns the eta of the train') do
      test_train = Train.new({:id => nil, :eta => Time.new(2015)})
      expect(test_train.eta()).to(eq(Time.new(2015)))
    end
  end

  describe('.all') do
    it('starts out empty') do
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a train to the list of trains') do
      test_train = Train.new({:id => nil, :eta => Time.new()})
      test_train.save()
      test_train2 = Train.new({:id => nil, :eta => Time.new()})
      test_train2.save()
      expect(Train.all()).to(eq([test_train, test_train2]))
    end
  end

  describe('#update') do
    it('updates the train eta') do
      test_train = Train.new({:id => nil, :eta => Time.new()})
      test_train.save()
      test_train.update({:eta => Time.new(2016)})
      expect(test_train.eta()).to(eq(Time.new(2016)))
    end
  end

  describe('#delete') do
    it('deletes the train') do
      test_train = Train.new({:id => nil, :eta => Time.new()})
      test_train.save()
      test_train2 = Train.new({:id => nil, :eta => Time.new()})
      test_train2.save()
      test_train.delete()
      expect(Train.all()).to(eq([test_train2]))
    end
  end
end
