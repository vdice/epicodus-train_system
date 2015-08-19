require('spec_helper')

describe(Train) do
  describe('#id') do
    it('returns the id of the train') do
      test_train = Train.new({:id => nil, :eta => Time.new(), :city_id => 1})
      test_train.save()
      expect(test_train.id()).to(be_an_instance_of(Fixnum))
    end
  end
end
