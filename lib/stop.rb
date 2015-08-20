class Stop
  attr_reader(:train, :city, :eta, :id)

  define_method(:initialize) do |attributes|
    @train = attributes.fetch(:train)
    @city = attributes.fetch(:city)
    @eta = attributes.fetch(:eta)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stops (train_id, city_id, eta) VALUES (#{@train.id()}, #{@city.id()}, '#{@eta}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_stops = DB.exec("SELECT * FROM stops;")
    stops = []
    returned_stops.each() do |stop|
      train = Train.find(stop.fetch('train_id').to_i())
      city = City.find(stop.fetch('city_id').to_i())
      eta = Time.parse(stop.fetch('eta'))
      id = stop.fetch('id').to_i()
      stops.push(Stop.new({:train => train, :city => city, :eta => eta, :id => id}))
    end
    stops
  end

  define_method(:==) do |other|
    same_train = @train.==(other.train())
    same_city = @city.==(other.city())
    same_eta = @eta.==(other.eta())
    same_train.&(same_city).&(same_eta)
  end

  define_singleton_method(:find) do |id|
    Stop.all.each do |stop|
      if id == stop.id
        return stop
      end
    end
  end
end
