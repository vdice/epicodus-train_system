class Stop
  attr_reader(:train, :city, :eta)

  define_method(:initialize) do |attributes|
    @train = attributes.fetch(:train)
    @city = attributes.fetch(:city)
    @eta = attributes.fetch(:eta)
  end

  define_method(:save) do
    DB.exec("INSERT INTO stops (train_id, city_id, eta) VALUES (#{@train.id()}, #{@city.id()}, '#{@eta}')")
  end
end
