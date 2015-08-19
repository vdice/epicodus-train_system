class Train
  attr_reader(:id, :eta, :city_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @eta = attributes.fetch(:eta)
    @city_id = attributes.fetch(:city_id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (eta, city_id) VALUES ('#{@eta}', #{@city_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      id = train.fetch('id').to_i()
      eta = Time.parse(train.fetch('eta'))
      city_id = train.fetch('city_id').to_i()
      trains.push(Train.new({:id => id, :eta => eta, :city_id => city_id}))
    end
    trains
  end

  define_method(:==) do |other|
    self.id()==other.id()
  end
end
