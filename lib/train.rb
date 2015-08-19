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

  define_method(:update) do |attributes|
    set_items = []
    if attributes.has_key?(:city_id)
      @city_id = attributes.fetch(:city_id)
      set_items.push("city_id = #{@city_id}")
    end

    if attributes.has_key?(:eta)
      @eta = attributes.fetch(:eta)
      set_items.push("eta = '#{@eta}'")
    end

    set_string = ""
    if set_items.length().>(1)
      set_string = set_items.join(',')
    else
      set_string = set_items.join('')
    end
    DB.exec("UPDATE trains SET #{set_string} WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end
end
