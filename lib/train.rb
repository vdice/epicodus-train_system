class Train
  attr_reader(:name, :eta, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @eta = attributes.fetch(:eta)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name, eta) VALUES ('#{@name}', '#{@eta}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch('name')
      eta = Time.parse(train.fetch('eta'))
      id = train.fetch('id').to_i()
      trains.push(Train.new({:name => name, :eta => eta, :id => id}))
    end
    trains
  end

  define_method(:==) do |other|
    self.id()==other.id()
  end

  define_method(:update) do |attributes|
    set_items = []
    if attributes.has_key?(:name)
      @name = attributes.fetch(:name)
      set_items.push("name = '#{@name}'")
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

  define_singleton_method(:find) do |id|
    Train.all.each do |train|
      if train.id == id
        return train
      end
    end
  end
end
