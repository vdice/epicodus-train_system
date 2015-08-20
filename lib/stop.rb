class Stop
  attr_reader(:train, :city, :eta)

  define_method(:initialize) do |attributes|
    @train = attributes.fetch(:train)
    @city = attributes.fetch(:city)
    @eta = attributes.fetch(:eta)
  end

  define_method(:save) do
    DB.exec("INSERT INTO stops (train_id, city_id, eta) VALUES (#{@train.id()}, #{@city.id()}, '#{@eta}');")
  end

  define_singleton_method(:all) do
    returned_stops = DB.exec("SELECT * FROM stops;")
    stops = []
    returned_stops.each() do |stop|
      train = Train.find(stop.fetch('train_id').to_i())
      city = City.find(stop.fetch('city_id').to_i())
      eta = Time.parse(stop.fetch('eta'))
      stops.push(Stop.new({:train => train, :city => city, :eta => eta}))
    end
    stops
  end

  define_method(:==) do |other|
    same_train = @train.==(other.train())
    same_city = @city.==(other.city())
    same_eta = @eta.==(other.eta())
    same_train.&(same_city).&(same_eta)
  end
end
