class Train
  attr_reader(:id, :eta)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @eta = attributes.fetch(:eta)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (eta) VALUES ('#{@eta}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      id = train.fetch('id').to_i()
      eta = Time.parse(train.fetch('eta'))
      trains.push(Train.new({:id => id, :eta => eta}))
    end
    trains
  end

  define_method(:==) do |other|
    self.id()==other.id()
  end

  define_method(:update) do |attributes|
    set_items = []
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
