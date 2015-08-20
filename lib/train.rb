class Train
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch('name')
      id = train.fetch('id').to_i()
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  define_method(:==) do |other|
    self.id()==other.id()
  end

  define_method(:update) do |attributes|

    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{self.id()}, #{city_id});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  define_singleton_method(:find) do |id|
    Train.all.each do |train|
      if train.id == id
        return train
      end
    end
  end

  define_method(:cities) do
    returned_cities = DB.exec("SELECT cities.* FROM trains JOIN stops ON (#{self.id()} = stops.train_id) JOIN cities ON (stops.city_id = cities.id) WHERE trains.id = #{self.id()};")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch('name')
      id = city.fetch('id').to_i()
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end
end
